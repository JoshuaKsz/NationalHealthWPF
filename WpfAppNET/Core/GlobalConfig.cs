using System.Data.SqlClient;
using System.Data;
using System;
using System.Windows.Controls; // For ComboBox and DataGrid
using System.Windows; // For MessageBox in WPF
using System.Text;

namespace NationalHealth
{
    public static class GlobalConfig
    {
        public static string ConnectionString = "Data Source=LAPTOP-NNF5G178\\SQLEXPRESS;Initial Catalog=NationalHealth;Integrated Security=True;TrustServerCertificate=True";


        public static void ExecQuery(string SP, SqlParameter[] parameters)
        {
            using (SqlConnection con = new SqlConnection(GlobalConfig.ConnectionString))
            {
                try
                {
                    con.Open();
                    using (SqlCommand cmd = new SqlCommand(SP, con))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        // Add parameters to the command
                        if (parameters != null)
                        {
                            cmd.Parameters.AddRange(parameters);
                        }

                        int rowsAffected = cmd.ExecuteNonQuery();
                        if (rowsAffected > 0)
                        {
                            MessageBox.Show(SP + " BERHASIL DIJALANKAN.");
                        }
                        else
                        {
                            MessageBox.Show(SP + " GAGAL DIJALANKAN.");
                        }

                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("An error occurred: " + ex.Message);
                }
            }
        }

        public static DataTable LoadData(string query)
        {
            DataTable dt = new DataTable();

            using (SqlConnection con = new SqlConnection(GlobalConfig.ConnectionString))
            {
                try
                {
                    con.Open();
                    using (SqlDataAdapter adapter = new SqlDataAdapter(query, con))
                    {
                        adapter.Fill(dt);  // Fill the DataTable with query result
                    }
                }
                catch (Exception ex)
                {
                    MessageBox.Show("An error occurred: " + ex.Message);
                }
            }
            ShowDataInMessageBox(dt);
            return dt; // Return the filled DataTable
        }
        public static void ShowDataInMessageBox(DataTable dt)
        {
            StringBuilder sb = new StringBuilder();

            // Add column names (optional)
            foreach (DataColumn column in dt.Columns)
            {
                sb.Append(column.ColumnName + "\t");
            }
            sb.AppendLine();

            // Add rows
            foreach (DataRow row in dt.Rows)
            {
                foreach (var item in row.ItemArray)
                {
                    sb.Append(item.ToString() + "\t");
                }
                sb.AppendLine();
            }

            // Show the formatted data in a MessageBox
            MessageBox.Show(sb.ToString(), "Data from Database", MessageBoxButton.OK, MessageBoxImage.Information);
        }


        // WPF version of LoadComboBox, using ComboBox
        public static void LoadComboBox(string query, string column, ComboBox comboBox)
        {
            try
            {
                using (SqlConnection connection = new SqlConnection(GlobalConfig.ConnectionString))
                {
                    SqlCommand command = new SqlCommand(query, connection);
                    connection.Open();
                    SqlDataReader reader = command.ExecuteReader();

                    while (reader.Read())
                    {
                        comboBox.Items.Add(reader[column].ToString());
                    }
                    reader.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("An error occurred: " + ex.Message);
            }
        }
    }
}
