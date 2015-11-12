using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.IO;
using System.ServiceModel.Web;

namespace imageservice{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de interfaz "Icamaras" en el código y en el archivo de configuración a la vez.
    [ServiceContract]
    public interface Icamaras{
        [OperationContract]
        Boolean NuevaCamara(Camara cam, string key);

        [OperationContract]
        List<Camara> ObtenerCamara();

        [OperationContract]
        Boolean EliminarCamara(String nombre, string key);

        [OperationContract]
        Streaming video(String nombre);

        [OperationContract]
        string imagen();

    
    }
}
