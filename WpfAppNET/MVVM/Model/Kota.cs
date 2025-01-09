using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace WpfAppNET.MVVM.Model
{
    internal class Kota : INotifyPropertyChanged
    {
        private string _id_kota;
        private string _id_provinsi;
        private string _nama_kota;

        public string id_kota
        {
            get { return _id_kota; }
            set { _id_kota = value; OnPropertyChanged("id_kota"); }
        }

        public string id_provinsi
        {
            get { return _id_provinsi; }
            set { _id_provinsi = value; OnPropertyChanged("id_provinsi"); }
        }

        public string nama_kota
        {
            get { return _nama_kota; }
            set { _nama_kota = value; OnPropertyChanged("nama_kota"); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
