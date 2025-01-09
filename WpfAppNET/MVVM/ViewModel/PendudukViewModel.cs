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
    internal class PendudukViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Penduduk> _PendudukList;

        public ObservableCollection<Penduduk> PendudukList
        {
            get { return _PendudukList; }
            set
            {
                _PendudukList = value;
                OnPropertyChanged(nameof(PendudukList));
            }
        }

        public PendudukViewModel()
        {
            _PendudukList = new ObservableCollection<Penduduk>();
            SelectedPendudukTextBox = new Penduduk();
            LoadData();
        }

        private Penduduk _selectedPenduduk;
        private Penduduk _selectedPendudukTextBox;

        public Penduduk SelectedPenduduk
        {
            get { return _selectedPenduduk; }
            set
            {
                if (_selectedPenduduk != value)
                {
                    _selectedPenduduk = value;
                    CopySelectedToEditable();
                    OnPropertyChanged(nameof(SelectedPenduduk));
                }
            }
        }

        public Penduduk SelectedPendudukTextBox
        {
            get { return _selectedPendudukTextBox; }
            set
            {
                if (_selectedPendudukTextBox != value)
                {
                    _selectedPendudukTextBox = value;
                    OnPropertyChanged(nameof(SelectedPendudukTextBox));
                }
            }
        }

        private void CopySelectedToEditable()
        {
            if (SelectedPenduduk != null)
            {
                SelectedPendudukTextBox = new Penduduk
                {
                    id_penduduk = SelectedPenduduk.id_penduduk,
                    nama = SelectedPenduduk.nama,
                    tanggal_lahir = SelectedPenduduk.tanggal_lahir,
                    jenis_kelamin = SelectedPenduduk.jenis_kelamin,
                    golongan_darah = SelectedPenduduk.golongan_darah,
                    alamat = SelectedPenduduk.alamat,
                    nomor_hp = SelectedPenduduk.nomor_hp,
                    status = SelectedPenduduk.status,
                    id_kecamatan = SelectedPenduduk.id_kecamatan
                };
                OnPropertyChanged(nameof(SelectedPendudukTextBox));
            }
        }

        private void LoadData()
        {
            try
            {
                DataTable dt = GlobalConfig.LoadData("SELECT * FROM Penduduk");

                _PendudukList.Clear();
                foreach (DataRow row in dt.Rows)
                {
                    _PendudukList.Add(new Penduduk
                    {
                        id_penduduk = row["id_penduduk"].ToString(),
                        nama = row["nama"].ToString(),
                        tanggal_lahir = row["tanggal_lahir"].ToString(),
                        jenis_kelamin = row["jenis_kelamin"].ToString(),
                        golongan_darah = row["golongan_darah"].ToString(),
                        alamat = row["alamat"].ToString(),
                        nomor_hp = row["nomor_hp"].ToString(),
                        status = row["status"].ToString(),
                        id_kecamatan = row["id_kecamatan"].ToString()
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
            private PendudukViewModel _viewModel;

            public Insert(PendudukViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                //new SqlParameter("@tanggal_lahir", SqlDbType.DateTime) { Value = dateTimePicker1.Text },
                SqlParameter[] parameters = {
                    new SqlParameter("@id_penduduk", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedPendudukTextBox.id_penduduk },
                    new SqlParameter("@nama", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedPendudukTextBox.nama },
                    new SqlParameter("@tanggal_lahir", SqlDbType.DateTime ) { Value = _viewModel.SelectedPendudukTextBox.tanggal_lahir },
                    new SqlParameter("@jenis_kelamin", SqlDbType.VarChar, 10) { Value = _viewModel.SelectedPendudukTextBox.jenis_kelamin },
                    new SqlParameter("@golongan_darah", SqlDbType.VarChar, 4) { Value = _viewModel.SelectedPendudukTextBox.golongan_darah },
                    new SqlParameter("@alamat", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedPendudukTextBox.alamat },
                    new SqlParameter("@nomor_hp", SqlDbType.VarChar, 15) { Value = _viewModel.SelectedPendudukTextBox.nomor_hp },
                    new SqlParameter("@status", SqlDbType.VarChar, 20) { Value = _viewModel.SelectedPendudukTextBox.status },
                    new SqlParameter("@id_kecamatan", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedPendudukTextBox.id_kecamatan }
                };
                GlobalConfig.ExecQuery("SPInsPenduduk", parameters);
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
            private PendudukViewModel _viewModel;

            public Update(PendudukViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_penduduk", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedPendudukTextBox.id_penduduk },
                    new SqlParameter("@nama", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedPendudukTextBox.nama },
                    new SqlParameter("@tanggal_lahir", SqlDbType.DateTime ) { Value = _viewModel.SelectedPendudukTextBox.tanggal_lahir },
                    new SqlParameter("@jenis_kelamin", SqlDbType.VarChar, 10) { Value = _viewModel.SelectedPendudukTextBox.jenis_kelamin },
                    new SqlParameter("@golongan_darah", SqlDbType.VarChar, 4) { Value = _viewModel.SelectedPendudukTextBox.golongan_darah },
                    new SqlParameter("@alamat", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedPendudukTextBox.alamat },
                    new SqlParameter("@nomor_hp", SqlDbType.VarChar, 15) { Value = _viewModel.SelectedPendudukTextBox.nomor_hp },
                    new SqlParameter("@status", SqlDbType.VarChar, 20) { Value = _viewModel.SelectedPendudukTextBox.status },
                    new SqlParameter("@id_kecamatan", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedPendudukTextBox.id_kecamatan }
                };
                GlobalConfig.ExecQuery("SPUpdPenduduk", parameters);
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
            private PendudukViewModel _viewModel;

            public Delete(PendudukViewModel viewModel)
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
                        new SqlParameter("@id_penduduk", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedPendudukTextBox.id_penduduk }
                    };
                    GlobalConfig.ExecQuery("SPDelPenduduk", parameters);
                    _viewModel.LoadData();
                    _viewModel.SelectedPendudukTextBox = new Penduduk();
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

