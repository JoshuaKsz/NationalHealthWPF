using System;
using WpfAppNET.Core;
using WpfAppNET.MVVM.ViewModel;

namespace WpfAppNET.MVVM.ViewModel
{
    class MainViewModel : ObservableObject
    {

        public RelayCommand HomeViewCommand { get; set; }
        public RelayCommand DiscoveryViewCommand { get; set; }
        public RelayCommand Class1ViewCommand { get; set; }

        public HomeViewModel HomeVM { get; set; }

        public DiscoveryViewModel DiscoveryVM { get; set; }

        public Class1ViewModel Class1VM { get; set; }

        private object _currentView;
        
        public object CurrentView
        {
            get { return _currentView; }
            set 
            { 
                _currentView = value;
                OnPropertyChanged();
            }

        }

        public MainViewModel()
        {
            HomeVM = new HomeViewModel();
            DiscoveryVM = new DiscoveryViewModel();
            Class1VM = new Class1ViewModel();
            CurrentView = HomeVM;
            HomeViewCommand = new RelayCommand(o => 
            {
                CurrentView = HomeVM;
            });

            DiscoveryViewCommand = new RelayCommand(o =>
            {
                CurrentView = DiscoveryVM;
            });

            Class1ViewCommand = new RelayCommand(o =>
            {
                
                CurrentView = Class1VM;
            });
        }
    }
}
