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
    internal class KecamatanViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Kecamatan> _KecamatanList;

        public ObservableCollection<Kecamatan> KecamatanList
        {
            get { return _KecamatanList; }
            set
            {
                _KecamatanList = value;
                OnPropertyChanged(nameof(KecamatanList));
            }
        }

        public KecamatanViewModel()
        {
            _KecamatanList = new ObservableCollection<Kecamatan>();
            SelectedKecamatanTextBox = new Kecamatan();
            LoadData();
        }

        private Kecamatan _selectedKecamatan;
        private Kecamatan _selectedKecamatanTextBox;

        public Kecamatan SelectedKecamatan
        {
            get { return _selectedKecamatan; }
            set
            {
                if (_selectedKecamatan != value)
                {
                    _selectedKecamatan = value;
                    CopySelectedToEditable();
                    OnPropertyChanged(nameof(SelectedKecamatan));
                }
            }
        }

        public Kecamatan SelectedKecamatanTextBox
        {
            get { return _selectedKecamatanTextBox; }
            set
            {
                if (_selectedKecamatanTextBox != value)
                {
                    _selectedKecamatanTextBox = value;
                    OnPropertyChanged(nameof(SelectedKecamatanTextBox));
                }
            }
        }

        private void CopySelectedToEditable()
        {
            if (SelectedKecamatan != null)
            {
                SelectedKecamatanTextBox = new Kecamatan
                {
                    id_kecamatan = SelectedKecamatan.id_kecamatan,
                    id_kota = SelectedKecamatan.id_kota,
                    nama_kecamatan = SelectedKecamatan.nama_kecamatan
                };
                OnPropertyChanged(nameof(SelectedKecamatanTextBox));
            }
        }

        private void LoadData()
        {
            try
            {
                DataTable dt = GlobalConfig.LoadData("SELECT * FROM Kecamatan");

                _KecamatanList.Clear();
                foreach (DataRow row in dt.Rows)
                {
                    _KecamatanList.Add(new Kecamatan
                    {
                        id_kecamatan = row["id_kecamatan"].ToString(),
                        id_kota = row["id_kota"].ToString(),
                        nama_kecamatan = row["nama_kecamatan"].ToString()
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

        #region Command Implementation

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
            private KecamatanViewModel _viewModel;

            public Insert(KecamatanViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_kecamatan", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKecamatanTextBox.id_kecamatan },
                    new SqlParameter("@id_kota", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKecamatanTextBox.id_kota },
                    new SqlParameter("@nama_kecamatan", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedKecamatanTextBox.nama_kecamatan }
                };
                GlobalConfig.ExecQuery("SPInsKecamatan", parameters);
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
            private KecamatanViewModel _viewModel;

            public Update(KecamatanViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_kecamatan", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKecamatanTextBox.id_kecamatan },
                    new SqlParameter("@id_kota", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKecamatanTextBox.id_kota },
                    new SqlParameter("@nama_kecamatan", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedKecamatanTextBox.nama_kecamatan }
                };
                GlobalConfig.ExecQuery("SPUpdKecamatan", parameters);
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
            private KecamatanViewModel _viewModel;

            public Delete(KecamatanViewModel viewModel)
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
                        new SqlParameter("@id_kecamatan", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedKecamatanTextBox.id_kecamatan }
                    };
                    GlobalConfig.ExecQuery("SPDelKecamatan", parameters);
                    _viewModel.LoadData();
                    _viewModel.SelectedKecamatanTextBox = new Kecamatan();
                }
                else
                {
                    MessageBox.Show("Operation canceled");
                }
            }
        }

        #endregion
    }

}
