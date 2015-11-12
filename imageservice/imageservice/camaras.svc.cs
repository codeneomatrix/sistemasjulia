using System.Diagnostics;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Runtime.Serialization;
using System.ServiceModel;
using System.Text;
using System.ServiceModel.Activation;
using System.ServiceModel.Web;
using System.Web;
using NReco.VideoConverter;

namespace imageservice{
    // NOTA: puede usar el comando "Rename" del menú "Refactorizar" para cambiar el nombre de clase "camaras" en el código, en svc y en el archivo de configuración a la vez.
    // NOTA: para iniciar el Cliente de prueba WCF para probar este servicio, seleccione camaras.svc o camaras.svc.cs en el Explorador de soluciones e inicie la depuración.
   [ServiceBehavior(InstanceContextMode=InstanceContextMode.Single)]
    public class camaras : Icamaras{
       int puerto=8090;
        List<Camara> Camaras = new List<Camara>();

        #region Icamaras Members
        public Boolean NuevaCamara(Camara cam, string key){
            if (key == "123"){
                Camaras.Add(cam);
                return true;
            }
            return false;
        }

        public List<Camara> ObtenerCamara(){
            return Camaras;
        }

        public Boolean EliminarCamara(string nombre,string key){
            if (key == "123"){
                Camaras.Remove(Camaras.Find(e => e.nombre.Equals(nombre)));
                return true;
            }
            return false;
        }


        public Streaming video(string nombre)
        {
            string sesion;
            Camara vidcam = new Camara();
            vidcam= Camaras.Find(e => e.nombre.Equals(nombre));

            Streaming nes = new Streaming();
            nes.protocolo = "udp";
            nes.ip = "192.168.1.11";
            nes.puerto = Convert.ToString(puerto);
            puerto++;
            nes.dominio = nombre;
            nes.ffplay = "ffplay " + nes.protocolo + "://" + nes.ip + ":" + nes.puerto + "/" + nes.dominio;
            
            sesion = "ffmpeg -i http://"+vidcam.usuario+":"+vidcam.contraseña+"@"+vidcam.ip+"/video/mjpg.cgi -f mpegts "+nes.protocolo+"://"+nes.ip+":"+nes.puerto+"/"+nes.dominio;
            
            System.Diagnostics.ProcessStartInfo info = new System.Diagnostics.ProcessStartInfo("CMD.EXE", "/C" + sesion);
            //info.Verb = "open";
            info.WindowStyle = System.Diagnostics.ProcessWindowStyle.Hidden;
            System.Diagnostics.Process.Start(info);

            return nes;
        }

        public string imagen()
        {
            return "aqui va la foto";
        }

        
        #endregion 


    }
}
