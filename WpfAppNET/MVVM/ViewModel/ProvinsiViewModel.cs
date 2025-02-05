﻿using System.Collections.ObjectModel;
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
    internal class ProvinsiViewModel : INotifyPropertyChanged
    {
        private ObservableCollection<Provinsi> _ProvinsiList;

        public ObservableCollection<Provinsi> ProvinsiList
        {
            get { return _ProvinsiList; }
            set
            {
                _ProvinsiList = value;
                OnPropertyChanged(nameof(ProvinsiList));
            }
        }

        public ProvinsiViewModel()
        {
            _ProvinsiList = new ObservableCollection<Provinsi>();

            SelectedProvinsiTextBox = new Provinsi();

            LoadData();
        }

        private Provinsi _selectedProvinsi;
        private Provinsi _selectedProvinsiTextBox;

        public Provinsi SelectedProvinsi
        {
            get { return _selectedProvinsi; }
            set
            {
                if (_selectedProvinsi != value)
                {
                    _selectedProvinsi = value;
                    CopySelectedToEditable();
                    OnPropertyChanged(nameof(SelectedProvinsi));
                }
            }
        }
        public Provinsi SelectedProvinsiTextBox
        {
            get { return _selectedProvinsiTextBox; }
            set
            {
                if (_selectedProvinsiTextBox != value)
                {
                    _selectedProvinsiTextBox = value;
                    OnPropertyChanged(nameof(_selectedProvinsiTextBox));
                }
            }
        }

        private void CopySelectedToEditable()
        {
            if (SelectedProvinsi != null)
            {
                SelectedProvinsiTextBox = new Provinsi
                {
                    id_provinsi = SelectedProvinsi.id_provinsi,
                    nama_provinsi = SelectedProvinsi.nama_provinsi
                };
                OnPropertyChanged(nameof(SelectedProvinsiTextBox));

            }
        }

        private void LoadData()
        {
            try
            {

                DataTable dt = GlobalConfig.LoadData("SELECT * FROM Provinsi");

                _ProvinsiList.Clear();
                foreach (DataRow row in dt.Rows)
                {
                    _ProvinsiList.Add(new Provinsi
                    {
                        id_provinsi = row["id_provinsi"].ToString(),
                        nama_provinsi = row["nama_provinsi"].ToString()
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
            private ProvinsiViewModel _viewModel;

            public Insert(ProvinsiViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {

                SqlParameter[] parameters = {
                    new SqlParameter("@id_provinsi", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedProvinsiTextBox.id_provinsi.ToString() },
                    new SqlParameter("@nama_provinsi", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedProvinsiTextBox.nama_provinsi.ToString() }
                };
                GlobalConfig.ExecQuery("SPInsProvinsi", parameters);
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
            private ProvinsiViewModel _viewModel;

            public Update(ProvinsiViewModel viewModel)
            {
                _viewModel = viewModel;
            }

            public bool CanExecute(object parameter) => true;

            public event EventHandler CanExecuteChanged;

            public void Execute(object parameter)
            {
                SqlParameter[] parameters = {
                    new SqlParameter("@id_provinsi", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedProvinsiTextBox.id_provinsi.ToString() },
                    new SqlParameter("@nama_provinsi", SqlDbType.VarChar, 50) { Value = _viewModel.SelectedProvinsiTextBox.nama_provinsi.ToString() }
                };
                GlobalConfig.ExecQuery("SPUpdProvinsi", parameters);

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
            private ProvinsiViewModel _viewModel;

            public Delete(ProvinsiViewModel viewModel)
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
                        new SqlParameter("@id_provinsi", SqlDbType.VarChar, 16) { Value = _viewModel.SelectedProvinsiTextBox.id_provinsi.ToString() },
                    };
                    GlobalConfig.ExecQuery("SPDelProvinsi", parameters);
                    _viewModel.LoadData();
                    _viewModel.SelectedProvinsiTextBox = new Provinsi();
                }
                else
                {
                    MessageBox.Show("canceled");
                }
            }

        }


    }
}
