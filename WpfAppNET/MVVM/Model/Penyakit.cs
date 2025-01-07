using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace WpfAppNET.MVVM.Model
{
    public class Penyakit : INotifyPropertyChanged
    {
        private string _id_penyakit;
        private string _mikroorganisme;
        private string _nama_family;

        public string id_penyakit
        {
            get { return _id_penyakit; }
            set { _id_penyakit = value; OnPropertyChanged("id_penyakit"); }
        }

        public string mikroorganisme
        {
            get { return _mikroorganisme; }
            set { _mikroorganisme = value; OnPropertyChanged("mikroorganisme"); }
        }

        public string nama_family
        {
            get { return _nama_family; }
            set { _nama_family = value; OnPropertyChanged("nama_family"); }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged([CallerMemberName] string propertyName = null)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }
    }

}
