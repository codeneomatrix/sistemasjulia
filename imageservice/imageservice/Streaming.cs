using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Runtime.Serialization;
namespace imageservice
{
    public class Streaming
    {
        [DataMember]
        public string protocolo;
        [DataMember]
        public string ip;
        [DataMember]
        public string puerto;
        [DataMember]
        public string dominio;
        [DataMember]
        public string ffplay;

    }
}