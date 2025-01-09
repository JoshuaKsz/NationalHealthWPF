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
    internal class RiwayatPenyakitViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<RiwayatPenyakit> _RiwayatPenyakitList;

        public ObservableCollection<RiwayatPenyakit> RiwayatPenyakitList
        {
            get { return _RiwayatPenyakitList; }
            set
            {
                _RiwayatPenyakitList = value;
                OnPropertyChanged(nameof(RiwayatPenyakitList));
            }
        }

        public RiwayatPenyakitViewModel()
        {
            _RiwayatPenyakitList = new ObservableCollection<RiwayatPenyakit>();
            SelectedRiwayatPenyakitTextBox = new RiwayatPenyakit();
            LoadData();
        }

        private RiwayatPenyakit _selectedRiwayatPenyakit;
        private RiwayatPenyakit _selectedRiwayatPenyakitTextBox;

        public RiwayatPenyakit SelectedRiwayatPenyakit
        {
            get { return _selectedRiwayatPenyakit; }
            set
            {
                if (_selectedRiwayatPenyakit != value)
                {
                    _selectedRiwayatPenyakit = value;
                    CopySelectedToEditable();
                    OnPropertyChanged(nameof(SelectedRiwayatPenyakit));
                }
            }
        }

        public RiwayatPenyakit SelectedRiwayatPenyakitTextBox
        {
            get { return _selectedRiwayatPenyakitTextBox; }
            set
            {
                if (_selectedRiwayatPenyakitTextBox != value)
                {
                    _selectedRiwayatPenyakitTextBox = value;
                    OnPropertyChanged(nameof(SelectedRiwayatPenyakitTextBox));
                }
            }
        }

        private void CopySelectedToEditable()
        {
            if (SelectedRiwayatPenyakit != null)
            {
                SelectedRiwayatPenyakitTextBox = new RiwayatPenyakit
                {
                    id_riwayat = SelectedRiwayatPenyakit.id_riwayat,
                    id_penduduk = SelectedRiwayatPenyakit.id_penduduk,
                    id_rumah_sakit = SelectedRiwayatPenyakit.id_rumah_sakit,
                    id_penyakit = SelectedRiwayatPenyakit.id_penyakit,
                    awal_sakit = SelectedRiwayatPenyakit.awal_sakit,
                    akhir_sakit = SelectedRiwayatPenyakit.akhir_sakit
                };
                OnPropertyChanged(nameof(SelectedRiwayatPenyakitTextBox));
            }
        }

        private void LoadData()
        {
            try
            {
                DataTable dt = GlobalConfig.LoadData("SELECT * FROM riwayat_penyakit");

                _RiwayatPenyakitList.Clear();
                foreach (DataRow row in dt.Rows)
                {
                    _RiwayatPenyakitList.Add(new RiwayatPenyakit
                    {
                        id_riwayat = row["id_riwayat"].ToString(),
                        id_penduduk = row["id_penduduk"].ToString(),
                        id_rumah_sakit = row["id_rumah_sakit"].ToString(),
                        id_penyakit = row["id_penyakit"].ToString(),
                        awal_sakit = row["awal_sakit"].ToString(),
                        akhir_sakit = row["akhir_sakit"].ToString()
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
            private RiwayatPenyakitViewModel _viewModel;

            public Insert(RiwayatPenyakitViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_riwayat", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_riwayat },
                    new SqlParameter("@id_penduduk", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_penduduk },
                    new SqlParameter("@id_rumah_sakit", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_rumah_sakit },
                    new SqlParameter("@id_penyakit", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_penyakit },
                    new SqlParameter("@awal_sakit", SqlDbType.DateTime) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.awal_sakit },
                    new SqlParameter("@akhir_sakit", SqlDbType.DateTime) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.akhir_sakit }
                };
                GlobalConfig.ExecQuery("SPInsRiwayat", parameters);
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
            private RiwayatPenyakitViewModel _viewModel;

            public Update(RiwayatPenyakitViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_riwayat", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_riwayat },
                    new SqlParameter("@id_penduduk", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_penduduk },
                    new SqlParameter("@id_rumah_sakit", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_rumah_sakit },
                    new SqlParameter("@id_penyakit", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_penyakit },
                    new SqlParameter("@awal_sakit", SqlDbType.DateTime) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.awal_sakit },
                    new SqlParameter("@akhir_sakit", SqlDbType.DateTime) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.akhir_sakit }
                };
                GlobalConfig.ExecQuery("SPUpdRiwayat", parameters);
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
            private RiwayatPenyakitViewModel _viewModel;

            public Delete(RiwayatPenyakitViewModel viewModel)
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
                        new SqlParameter("@id_riwayat", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRiwayatPenyakitTextBox.id_riwayat }
                    };
                    GlobalConfig.ExecQuery("SPDelRiwayat", parameters);
                    _viewModel.LoadData();
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
