using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Linq;
using System.Runtime.CompilerServices;
using System.Text;
using System.Threading.Tasks;

namespace WpfAppNET.MVVM.Model
{
    public class TextBox : INotifyPropertyChanged
    {
        private string _textBoxValue;

        public string TextBoxValue
        {
            get { return _textBoxValue; }
            set
            {
                if (_textBoxValue != value)
                {
                    _textBoxValue = value;
                    OnPropertyChanged(nameof(TextBoxValue));
                }
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

    }

}
