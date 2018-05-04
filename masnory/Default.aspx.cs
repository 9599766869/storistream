using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Data;
using System.Web.Services;

public partial class _Default : System.Web.UI.Page
{
    SqlCommand cmd = new SqlCommand();
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    private static DataTable BindRepeater(int PageIndex)
    {
        DataTable dtresult = new DataTable();
        string constr = System.Configuration.ConfigurationManager.ConnectionStrings["StockInventory"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            con.Open();
            SqlCommand cmd = new SqlCommand("GetCustomersPageWise", con);
            cmd.Parameters.AddWithValue("@PageIndex", PageIndex);
            cmd.Parameters.AddWithValue("@PageSize", 50);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlDataAdapter da = new SqlDataAdapter(cmd);
            da.Fill(dtresult);
        }
        return dtresult;
    }
    [WebMethod]
    public static List<Customer> GetCustomer2(int PageIndex)
    {
        List<Customer> customers = new List<Customer>();
        DataTable dt = new DataTable();
        dt = BindRepeater(PageIndex);

        foreach (DataRow dtrow in dt.Rows)
        {
            customers.Add(new Customer
            {
                BrandId = dtrow["BrandId"].ToString(),
                BrandName = dtrow["BrandName"].ToString(),
                logo = dtrow["logo"].ToString(),

            });

        }
        return customers;

    }


    [WebMethod]
    public static List<Customer> GetCustomers()
    {
        string constr = System.Configuration.ConfigurationManager.ConnectionStrings["StockInventory"].ConnectionString;
        using (SqlConnection con = new SqlConnection(constr))
        {
            using (SqlCommand cmd = new SqlCommand("SELECT top 50 * FROM Brand"))
            {
                cmd.Connection = con;
                List<Customer> customers = new List<Customer>();
                con.Open();
                using (SqlDataReader sdr = cmd.ExecuteReader())
                {
                    while (sdr.Read())
                    {
                        customers.Add(new Customer
                        {
                            BrandId = sdr["BrandId"].ToString(),
                            BrandName = sdr["BrandName"].ToString(),
                            logo = sdr["logo"].ToString(),

                        });
                    }
                }
                con.Close();
                return customers;
            }
        }
    }
}