using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace WpfAppNET.MVVM.Model
{
    internal class Provinsi : INotifyPropertyChanged
    {
        private string _id_provinsi;
        private string _nama_provinsi;

        public string id_provinsi
        {
            get { return _id_provinsi; }
            set { _id_provinsi = value; OnPropertyChanged("id_provinsi"); }
        }

        public string nama_provinsi
        {
            get { return _nama_provinsi; }
            set { _nama_provinsi = value; OnPropertyChanged("nama_provinsi"); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
