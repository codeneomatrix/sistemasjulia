using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;

namespace imageservice
{   
    [DataContract()]
    public class Camara
    {   
        [DataMember]
        public string ip;
        [DataMember]
        public string nombre;
        [DataMember]
        public string usuario;
        [DataMember]
        public string contraseña;

    }
}