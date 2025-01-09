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
    internal class RumahSakitViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<RumahSakit> _RumahSakitList;

        public ObservableCollection<RumahSakit> RumahSakitList
        {
            get { return _RumahSakitList; }
            set
            {
                _RumahSakitList = value;
                OnPropertyChanged(nameof(RumahSakitList));
            }
        }

        public RumahSakitViewModel()
        {
            _RumahSakitList = new ObservableCollection<RumahSakit>();
            SelectedRumahSakitTextBox = new RumahSakit();
            LoadData();
        }

        private RumahSakit _selectedRumahSakit;
        private RumahSakit _selectedRumahSakitTextBox;

        public RumahSakit SelectedRumahSakit
        {
            get { return _selectedRumahSakit; }
            set
            {
                if (_selectedRumahSakit != value)
                {
                    _selectedRumahSakit = value;
                    CopySelectedToEditable();
                    OnPropertyChanged(nameof(SelectedRumahSakit));
                }
            }
        }

        public RumahSakit SelectedRumahSakitTextBox
        {
            get { return _selectedRumahSakitTextBox; }
            set
            {
                if (_selectedRumahSakitTextBox != value)
                {
                    _selectedRumahSakitTextBox = value;
                    OnPropertyChanged(nameof(SelectedRumahSakitTextBox));
                }
            }
        }

        private void CopySelectedToEditable()
        {
            if (SelectedRumahSakit != null)
            {
                SelectedRumahSakitTextBox = new RumahSakit
                {
                    id_rumah_sakit = SelectedRumahSakit.id_rumah_sakit,
                    nama_rumah_sakit = SelectedRumahSakit.nama_rumah_sakit,
                    id_kecamatan = SelectedRumahSakit.id_kecamatan
                };
                OnPropertyChanged(nameof(SelectedRumahSakitTextBox));
            }
        }

        private void LoadData()
        {
            try
            {
                DataTable dt = GlobalConfig.LoadData("SELECT * FROM rumah_sakit");

                _RumahSakitList.Clear();
                foreach (DataRow row in dt.Rows)
                {
                    _RumahSakitList.Add(new RumahSakit
                    {
                        id_rumah_sakit = row["id_rumah_sakit"].ToString(),
                        nama_rumah_sakit = row["nama_rumah_sakit"].ToString(),
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
            private RumahSakitViewModel _viewModel;

            public Insert(RumahSakitViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_rumah_sakit", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRumahSakitTextBox.id_rumah_sakit },
                    new SqlParameter("@nama_rumah_sakit", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedRumahSakitTextBox.nama_rumah_sakit },
                    new SqlParameter("@id_kecamatan", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRumahSakitTextBox.id_kecamatan }
                };
                GlobalConfig.ExecQuery("SPInsRumah", parameters);
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
            private RumahSakitViewModel _viewModel;

            public Update(RumahSakitViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_rumah_sakit", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRumahSakitTextBox.id_rumah_sakit },
                    new SqlParameter("@nama_rumah_sakit", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedRumahSakitTextBox.nama_rumah_sakit },
                    new SqlParameter("@id_kecamatan", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRumahSakitTextBox.id_kecamatan }
                };
                GlobalConfig.ExecQuery("SPUpdRumah", parameters);
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
            private RumahSakitViewModel _viewModel;

            public Delete(RumahSakitViewModel viewModel)
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
                        new SqlParameter("@id_rumah_sakit", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedRumahSakitTextBox.id_rumah_sakit }
                    };
                    GlobalConfig.ExecQuery("SPDelRumah", parameters);
                    _viewModel.LoadData();
                    _viewModel.SelectedRumahSakitTextBox = new RumahSakit();
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
