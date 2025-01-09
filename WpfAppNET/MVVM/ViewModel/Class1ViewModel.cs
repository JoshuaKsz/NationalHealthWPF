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
    internal class Class1ViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Penyakit> _PenyakitList;

        public Class1ViewModel()
        {
            _PenyakitList = new ObservableCollection<Penyakit>();
            SelectedPenyakitTextBox = new Penyakit();

            LoadData();
        }
        private Penyakit _selectedPenyakit;
        private Penyakit _selectedPenyakitTextBox;

        public Penyakit SelectedPenyakit
        {
            get { return _selectedPenyakit; }
            set
            {
                if (_selectedPenyakit != value)
                {
                    _selectedPenyakit = value;
                    CopySelectedToEditable();
                    OnPropertyChanged(nameof(SelectedPenyakit));
                }
            }
        }

        public Penyakit SelectedPenyakitTextBox
        {
            get { return _selectedPenyakitTextBox; }
            set
            {
                if (_selectedPenyakitTextBox != value)
                {
                    _selectedPenyakitTextBox = value;
                    OnPropertyChanged(nameof(SelectedPenyakitTextBox));
                }
            }
        }

        private void CopySelectedToEditable()
        {
            if (SelectedPenyakit != null)
            {
                // Create a new instance of Penyakit and copy the values from SelectedPenyakit
                SelectedPenyakitTextBox = new Penyakit
                {
                    id_penyakit = SelectedPenyakit.id_penyakit,
                    mikroorganisme = SelectedPenyakit.mikroorganisme,
                    nama_family = SelectedPenyakit.nama_family
                };
            }
        }


        public ObservableCollection<Penyakit> PenyakitList
        {
            get { return _PenyakitList; }
            set { 
                _PenyakitList = value;
                OnPropertyChanged(nameof(PenyakitList));
            }
        }
        

        public event PropertyChangedEventHandler PropertyChanged;
        protected virtual void OnPropertyChanged(string propertyName)
        {
            PropertyChanged?.Invoke(this, new PropertyChangedEventArgs(propertyName));
        }

        private void LoadData()
        {
            try
            {

                DataTable dt = GlobalConfig.LoadData("SELECT * FROM Penyakit");

                _PenyakitList.Clear();
                foreach (DataRow row in dt.Rows)
                {
                    _PenyakitList.Add(new Penyakit
                    {
                        id_penyakit = row["id_penyakit"].ToString(),
                        mikroorganisme = row["mikroorganisme"].ToString(),
                        nama_family = row["nama_family"].ToString()
                    });
                }

                Application.Current.Dispatcher.Invoke(() =>
                {
                    //MessageBox.Show("Data loaded successfully!", "Load Data", MessageBoxButton.OK, MessageBoxImage.Information);
                });
            }
            catch (Exception ex)
            {
                MessageBox.Show($"An error occurred: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }


        private ICommand mTestCommand;
        private ICommand mUpdateCommand;
        private ICommand mDeleteCommand;

        public ICommand TestCommand
        {
            get
            {
                if (mTestCommand == null)
                    mTestCommand = new Test(this);
                return mTestCommand;
            }
            set { mTestCommand = value; }
        }

        private class Test : ICommand
        {
            private Class1ViewModel _viewModel;

            public Test(Class1ViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_penyakit", SqlDbType.VarChar, 40) { Value = _viewModel.SelectedPenyakitTextBox.id_penyakit.ToString() },
                    new SqlParameter("@mikroorganisme", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedPenyakitTextBox.mikroorganisme.ToString() },
                    new SqlParameter("@nama_family", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedPenyakitTextBox.nama_family.ToString() },
                };
                MessageBox.Show(_viewModel.SelectedPenyakitTextBox.id_penyakit + _viewModel.SelectedPenyakitTextBox.mikroorganisme + _viewModel.SelectedPenyakitTextBox.nama_family);
                GlobalConfig.ExecQuery("SPInsPenyakit", parameters);
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
            set
            {
                mUpdateCommand = value;
            }
        }

        private class Update : ICommand
        {
            private Class1ViewModel _viewModel;

            public Update(Class1ViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                new SqlParameter("@id_penyakit", SqlDbType.VarChar, 40) { Value = _viewModel.SelectedPenyakitTextBox.id_penyakit.ToString() },
                    new SqlParameter("@mikroorganisme", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedPenyakitTextBox.mikroorganisme.ToString() },
                    new SqlParameter("@nama_family", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedPenyakitTextBox.nama_family.ToString() },
                };
                MessageBox.Show(_viewModel.SelectedPenyakitTextBox.id_penyakit + _viewModel.SelectedPenyakitTextBox.mikroorganisme + _viewModel.SelectedPenyakitTextBox.nama_family);
                GlobalConfig.ExecQuery("SPUpdPenyakit", parameters);

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
            set
            {
                mUpdateCommand = value;
            }
        }

        private class Delete : ICommand
        {
            private Class1ViewModel _viewModel;

            public Delete(Class1ViewModel viewModel)
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
                        new SqlParameter("@id_penyakit", SqlDbType.VarChar, 40) { Value = _viewModel.SelectedPenyakitTextBox.id_penyakit.ToString() },
                    };
                    GlobalConfig.ExecQuery("SPDelPenyakit", parameters);
                    _viewModel.LoadData();
                    _viewModel.SelectedPenyakitTextBox = new Penyakit();
                }
                else
                {
                    MessageBox.Show("canceled");
                }
            }

        }

    }

}