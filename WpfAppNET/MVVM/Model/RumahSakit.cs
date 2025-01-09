using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace WpfAppNET.MVVM.Model
{
    internal class RumahSakit : INotifyPropertyChanged
    {
        private string _id_rumah_sakit;
        private string _nama_rumah_sakit;
        private string _id_kecamatan;

        public string id_rumah_sakit
        {
            get { return _id_rumah_sakit; }
            set { _id_rumah_sakit = value; OnPropertyChanged("id_rumah_sakit"); }
        }

        public string nama_rumah_sakit
        {
            get { return _nama_rumah_sakit; }
            set { _nama_rumah_sakit = value; OnPropertyChanged("nama_rumah_sakit"); }
        }

        public string id_kecamatan
        {
            get { return _id_kecamatan; }
            set { _id_kecamatan = value; OnPropertyChanged("id_kecamatan"); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }
}
