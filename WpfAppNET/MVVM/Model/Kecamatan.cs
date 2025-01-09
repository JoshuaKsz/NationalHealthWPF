using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

using System.ComponentModel;
using System.Runtime.CompilerServices;

namespace WpfAppNET.MVVM.Model
{
    internal class Kecamatan : INotifyPropertyChanged
    {
        private string _id_kecamatan;
        private string _id_kota;
        private string _nama_kecamatan;

        public string id_kecamatan
        {
            get { return _id_kecamatan; }
            set { _id_kecamatan = value; OnPropertyChanged("id_kecamatan"); }
        }

        public string id_kota
        {
            get { return _id_kota; }
            set { _id_kota = value; OnPropertyChanged("id_kota"); }
        }

        public string nama_kecamatan
        {
            get { return _nama_kecamatan; }
            set { _nama_kecamatan = value; OnPropertyChanged("nama_kecamatan"); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
