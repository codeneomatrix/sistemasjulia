using HttpServer

# Load the Sudoku solver
require("sudoku.jl")

# Build the request handler
http = HttpHandler() do req::Request, res::Response
  if ismatch(r"^/sudoku/", req.resource)
    # Expecting 81 numbers between 0 and 9
    reqsplit = split(req.resource, "/")
    # ...snip validation...#
    probstr = reqsplit[3]
    if length(probstr) != 81
      return Response(400, "Error: expected 81 numbers.")
    end
    
    # Convert string into numbers, and place in matrix
    # Return error if any non-numbers or numbers out of range detected
    prob = zeros(Int,9,9)
    pos = 1
    try
      for row = 1:9
        for col = 1:9
          val = int(probstr[pos:pos])
          if val < 0 || val > 10
            return Response(422, "Error: number out of range 0:9.")
          end
          prob[row,col] = val
          pos += 1
        end
      end
    catch
      return Response(422, "Error: couldn't parse numbers.")
    end

    # Attempt to solve the problem using integer programming
    try
      sol = SolveModel(prob)
      if prettyoutput
        # Human readable output
        out = "<table>"
        for row = 1:9
          out = string(out,"<tr>")
          for col = 1:9
            out = string(out,"<td>",sol[row,col],"</td>")
          end
          out = string(out,"</tr>")
        end
        out = string(out,"</table>")
        return Response(out)
      else
        # Return solution like input
        return Response(join(sol,""))
      end
    catch
      return Response(422, "Error: coudn't solve puzzle.")
    end
  else
    # Not a valid URL
    return Response(404)
  end
end

# Boot up the server
server = Server(http)
run(server, 8000)
