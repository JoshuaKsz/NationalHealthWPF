using System;
using WpfAppNET.Core;
using WpfAppNET.MVVM.Model;
using WpfAppNET.MVVM.ViewModel;

namespace WpfAppNET.MVVM.ViewModel
{
    class MainViewModel : ObservableObject
    {
        
        public RelayCommand HomeViewCommand { get; set; }
        public RelayCommand DiscoveryViewCommand { get; set; }
        public RelayCommand Class1ViewCommand { get; set; }
        public RelayCommand ProvinsiViewCommand { get; set; }
        public RelayCommand KotaViewCommand { get; set; }
        public RelayCommand KecamatanViewCommand { get; set; }
        public RelayCommand PendudukViewCommand { get; set; }
        public RelayCommand RiwayatPenyakitViewCommand { get; set; }
        public RelayCommand RumahSakitViewCommand { get; set; }



        public HomeViewModel HomeVM { get; set; }
        public DiscoveryViewModel DiscoveryVM { get; set; }
        public Class1ViewModel Class1VM { get; set; }
        public ProvinsiViewModel ProvinsiVM { get; set; }
        public KotaViewModel KotaVM { get; set; }
        public KecamatanViewModel KecamatanVM { get; set; }
        public PendudukViewModel PendudukVM { get; set; }
        public RiwayatPenyakitViewModel RiwayatPenyakitVM { get; set; }
        public RumahSakitViewModel RumahSakitVM { get; set; }



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
            ProvinsiVM = new ProvinsiViewModel();
            KotaVM = new KotaViewModel();
            KecamatanVM = new KecamatanViewModel();
            PendudukVM = new PendudukViewModel();
            RiwayatPenyakitVM = new RiwayatPenyakitViewModel();
            RumahSakitVM = new RumahSakitViewModel();


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


            ProvinsiViewCommand = new RelayCommand(o =>
            {

                CurrentView = ProvinsiVM;
            });

            KotaViewCommand = new RelayCommand(o =>
            {
                CurrentView = KotaVM;
            });

            KecamatanViewCommand = new RelayCommand(o =>
            {
                CurrentView = KecamatanVM;
            });

            PendudukViewCommand = new RelayCommand(o =>
            {
                CurrentView = PendudukVM;
            });

            RiwayatPenyakitViewCommand = new RelayCommand(o =>
            {
                CurrentView = RiwayatPenyakitVM;
            });

            RumahSakitViewCommand = new RelayCommand(o =>
            {
                CurrentView = RumahSakitVM;
            });

        }
    }
}
