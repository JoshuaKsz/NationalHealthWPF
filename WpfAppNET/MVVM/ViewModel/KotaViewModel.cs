using System.Collections.ObjectModel;
using System.Windows.Input;
using System.Windows;
using System;
using WpfAppNET.MVVM.Model;
using WpfAppNET.Core;
using NationalHealth;
using System.Data;
using System.Windows.Controls;
using System.Xml.Linq;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.SqlClient;


namespace WpfAppNET.MVVM.ViewModel
{
    internal class KotaViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Kota> _KotaList;

        public ObservableCollection<Kota> KotaList
        {
            get { return _KotaList; }
            set
            {
                _KotaList = value;
                OnPropertyChanged(nameof(KotaList));
            }
        }

        public KotaViewModel()
        {
            _KotaList = new ObservableCollection<Kota>();
            SelectedKotaTextBox = new Kota();
            LoadData();
        }

        private Kota _selectedKota;
        private Kota _selectedKotaTextBox;

        public Kota SelectedKota
        {
            get { return _selectedKota; }
            set
            {
                if (_selectedKota != value)
                {
                    _selectedKota = value;
                    CopySelectedToEditable();
                    OnPropertyChanged(nameof(SelectedKota));
                }
            }
        }

        public Kota SelectedKotaTextBox
        {
            get { return _selectedKotaTextBox; }
            set
            {
                if (_selectedKotaTextBox != value)
                {
                    _selectedKotaTextBox = value;
                    OnPropertyChanged(nameof(SelectedKotaTextBox));
                }
            }
        }

        private void CopySelectedToEditable()
        {
            if (SelectedKota != null)
            {
                SelectedKotaTextBox = new Kota
                {
                    id_kota = SelectedKota.id_kota,
                    id_provinsi = SelectedKota.id_provinsi,
                    nama_kota = SelectedKota.nama_kota
                };
                OnPropertyChanged(nameof(SelectedKotaTextBox));
            }
        }

        private void LoadData()
        {
            try
            {
                DataTable dt = GlobalConfig.LoadData("SELECT * FROM Kota");

                _KotaList.Clear();
                foreach (DataRow row in dt.Rows)
                {
                    _KotaList.Add(new Kota
                    {
                        id_kota = row["id_kota"].ToString(),
                        id_provinsi = row["id_provinsi"].ToString(),
                        nama_kota = row["nama_kota"].ToString()
                    });
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }

        public event PropertyChangedEventHandler PropertyChanged;

        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private ICommand mInsertCommand;
        private ICommand mUpdateCommand;
        private ICommand mDeleteCommand;

        public ICommand InsertCommand
        {
            get
            {
                if (mInsertCommand == null)
                    mInsertCommand = new Insert(this);
                return mInsertCommand;
            }
            set { mInsertCommand = value; }
        }

        private class Insert : ICommand
        {
            private KotaViewModel _viewModel;

            public Insert(KotaViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_kota", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKotaTextBox.id_kota },
                    new SqlParameter("@id_provinsi", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKotaTextBox.id_provinsi },
                    new SqlParameter("@nama_kota", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedKotaTextBox.nama_kota }
                };
                GlobalConfig.ExecQuery("SPInsKota", parameters);
                _viewModel.LoadData();
            }
        }

        public ICommand UpdateCommand
        {
            get
            {
                if (mUpdateCommand == null)
                    mUpdateCommand = new Update(this);
                return mUpdateCommand;
            }
            set { mUpdateCommand = value; }
        }

        private class Update : ICommand
        {
            private KotaViewModel _viewModel;

            public Update(KotaViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_kota", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKotaTextBox.id_kota },
                    new SqlParameter("@id_provinsi", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKotaTextBox.id_provinsi },
                    new SqlParameter("@nama_kota", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedKotaTextBox.nama_kota }
                };
                GlobalConfig.ExecQuery("SPUpdKota", parameters);
                _viewModel.LoadData();
            }
        }

        public ICommand DeleteCommand
        {
            get
            {
                if (mDeleteCommand == null)
                    mDeleteCommand = new Delete(this);
                return mDeleteCommand;
            }
            set { mDeleteCommand = value; }
        }

        private class Delete : ICommand
        {
            private KotaViewModel _viewModel;

            public Delete(KotaViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                MessageBoxResult result = MessageBox.Show("Are you sure you want to proceed?", "Warning", MessageBoxButton.YesNo, MessageBoxImage.Warning);

                if (result == MessageBoxResult.Yes)
                {
                    SqlParameter[] parameters = {
                        new SqlParameter("@id_kota", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKotaTextBox.id_kota }
                    };
                    GlobalConfig.ExecQuery("SPDelKota", parameters);
                    _viewModel.LoadData();
                    _viewModel.SelectedKotaTextBox = new Kota();
                }
                else
                {
                    MessageBox.Show("Operation canceled");
                }
            }
        }



    }
}
