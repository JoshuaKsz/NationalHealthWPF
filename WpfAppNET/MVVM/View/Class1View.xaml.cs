﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using WpfAppNET.MVVM.ViewModel;

namespace WpfAppNET.MVVM.View
{
    /// <summary>
    /// Interaction logic for Class1View.xaml
    /// </summary>
    public partial class Class1View : UserControl
    {
        public Class1View()
        {
            InitializeComponent();

        }

        private void btnTest_Click(object sender, RoutedEventArgs e)
        {
            //MessageBox.Show("Hello, this is a test message!", "Test", MessageBoxButton.OK, MessageBoxImage.Information);
        }

        private void btnUpdate_Click(object sender, RoutedEventArgs e)
        {

        }
    }
}
