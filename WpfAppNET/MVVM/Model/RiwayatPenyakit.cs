using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace WpfAppNET.MVVM.Model
{
    internal class RiwayatPenyakit : INotifyPropertyChanged
    {
        private string _id_riwayat;
        private string _id_penduduk;
        private string _id_rumah_sakit;
        private string _id_penyakit;
        private string _awal_sakit;
        private string _akhir_sakit;

        public string id_riwayat
        {
            get { return _id_riwayat; }
            set { _id_riwayat = value; OnPropertyChanged("id_riwayat"); }
        }

        public string id_penduduk
        {
            get { return _id_penduduk; }
            set { _id_penduduk = value; OnPropertyChanged("id_penduduk"); }
        }

        public string id_rumah_sakit
        {
            get { return _id_rumah_sakit; }
            set { _id_rumah_sakit = value; OnPropertyChanged("id_rumah_sakit"); }
        }

        public string id_penyakit
        {
            get { return _id_penyakit; }
            set { _id_penyakit = value; OnPropertyChanged("id_penyakit"); }
        }

        public string awal_sakit
        {
            get { return _awal_sakit; }
            set { _awal_sakit = value; OnPropertyChanged("awal_sakit"); }
        }

        public string akhir_sakit
        {
            get { return _akhir_sakit; }
            set { _akhir_sakit = value; OnPropertyChanged("akhir_sakit"); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

}
