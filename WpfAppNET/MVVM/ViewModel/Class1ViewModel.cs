using System.Collections.ObjectModel;
using System.Windows.Input;
using System.Windows;
using System;
using WpfAppNET.MVVM.Model;
using WpfAppNET.Core;
using NationalHealth;
using System.Data;


namespace WpfAppNET.MVVM.ViewModel
{
    internal class Class1ViewModel
    {
        //private ObservableCollection<Class1> _Class1List;

        private ObservableCollection<Penyakit> _Class1List;

        private ObservableCollection<Penyakit> _PenyakitList;
        public Class1ViewModel()
        {
            _PenyakitList = new ObservableCollection<Penyakit>();

            LoadData();
            _Class1List = new ObservableCollection<Penyakit>
            {
                new Penyakit { id_penyakit = "kontol", mikroorganisme = "Raj", nama_family = "affad" },
            };
        }

        public ObservableCollection<Penyakit> PenyakitList
        {
            get { return _PenyakitList; }
            set { _PenyakitList = value; }
        }

        private void LoadData()
        {
            try
            {
                string query = "SELECT * FROM Penyakit"; // Adjust this as needed

                // Fetch the data as a DataTable from the static GlobalConfig class
                DataTable dt = GlobalConfig.LoadData(query);

                // Convert DataTable to ObservableCollection<Penyakit>
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

                // Show MessageBox (optional)
                Application.Current.Dispatcher.Invoke(() =>
                {
                    MessageBox.Show("Data loaded successfully!", "Load Data", MessageBoxButton.OK, MessageBoxImage.Information);
                });
            }
            catch (Exception ex)
            {
                // Handle the exception and show an error message
                MessageBox.Show($"An error occurred: {ex.Message}", "Error", MessageBoxButton.OK, MessageBoxImage.Error);
            }
        }


        private ICommand mTestCommand;

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
                _viewModel.LoadData();
            }
            
        }
    }

}