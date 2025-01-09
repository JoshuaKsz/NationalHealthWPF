using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace WpfAppNET.MVVM.Model
{
    internal class Penduduk : INotifyPropertyChanged
    {
        private string _id_penduduk;
        private string _nama;
        private string _tanggal_lahir;
        private string _jenis_kelamin;
        private string _golongan_darah;
        private string _alamat;
        private string _nomor_hp;
        private string _status;
        private string _id_kecamatan;

        public string id_penduduk
        {
            get { return _id_penduduk; }
            set { _id_penduduk = value; OnPropertyChanged("id_penduduk"); }
        }

        public string nama
        {
            get { return _nama; }
            set { _nama = value; OnPropertyChanged("nama"); }
        }

        public string tanggal_lahir
        {
            get { return _tanggal_lahir; }
            set { _tanggal_lahir = value; OnPropertyChanged("tanggal_lahir"); }
        }

        public string jenis_kelamin
        {
            get { return _jenis_kelamin; }
            set { _jenis_kelamin = value; OnPropertyChanged("jenis_kelamin"); }
        }

        public string golongan_darah
        {
            get { return _golongan_darah; }
            set { _golongan_darah = value; OnPropertyChanged("golongan_darah"); }
        }

        public string alamat
        {
            get { return _alamat; }
            set { _alamat = value; OnPropertyChanged("alamat"); }
        }

        public string nomor_hp
        {
            get { return _nomor_hp; }
            set { _nomor_hp = value; OnPropertyChanged("nomor_hp"); }
        }

        public string status
        {
            get { return _status; }
            set { _status = value; OnPropertyChanged("status"); }
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
