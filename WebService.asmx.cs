using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.Services;

namespace Ajax
{
    /// <summary>
    /// Summary description for WebService
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
    [System.Web.Script.Services.ScriptService]
    public class WebService : System.Web.Services.WebService
    {
        [WebMethod]
        public string HelloWorld()
        {
            return "Hello World";
        }

        [WebMethod]
        public string InsertUser(string Fname, string Lname, string Email, string ASP)
        {
            SqlConnection con = new SqlConnection("Data Source=DESKTOP-J3PUE9B;Database=DcodeTech;Integrated Security=SSPI");
            string sql = "insert into user_table(Fname,Lname,Email) values('" + Fname + "', '" + Lname + "', '" + Email + "')";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            int status = cmd.ExecuteNonQuery();
            con.Close();
            if (status > 0)
            {
                return "Successful !";
            }
            else
            {
                return "Failure !";
            }

        }

        [WebMethod]
        public string ShowUsers()
        {
            List<Users> userList = new List<Users>();

            SqlConnection con = new SqlConnection("Data Source=DESKTOP-J3PUE9B;Database=DcodeTech;Integrated Security=SSPI");
            con.Open();
            SqlCommand cmd = new SqlCommand("select ID, Fname, Lname, Email from user_table", con);
            SqlDataReader sdr = cmd.ExecuteReader();

            while (sdr.Read())
            {
                Users u = new Users();
                u.id = Convert.ToInt32(sdr["ID"]);
                u.fname = sdr["Fname"].ToString();
                u.lname = sdr["Lname"].ToString();
                u.email = sdr["Email"].ToString();

                userList.Add(u);
            }
            return JsonConvert.SerializeObject(userList);

            //JavaScriptSerializer js = new JavaScriptSerializer();
            //Context.Response.Write(js.Serialize(userList));
            //return js.Serialize(userList)

        }


        [WebMethod]
        public string searchUser(string inputkeys)
        {
            //SqlConnection con = new SqlConnection("Data Source = DESKTOP - J3PUE9B; Database = DcodeTech; Integrated Security = SSPI");
            //string sql = "select * from user_table where Fname like '%%' or Lname like '%%' or Email like '%%'";
            //con.Open();
            //SqlCommand cmd = new SqlCommand(sql, con);
            // cmd.ExecuteNonQuery();
            //con.Close();
            List<Users> userList = new List<Users>();

            SqlConnection con = new SqlConnection("Data Source=DESKTOP-J3PUE9B;Database=DcodeTech;Integrated Security=SSPI");
            con.Open();
            SqlCommand cmd = new SqlCommand("select * from user_table where ID like '%"+inputkeys+"%' or Fname like  '%"+ inputkeys + "%' or Lname like '%" + inputkeys + "%' or Email like '%" + inputkeys + "%'", con);
            SqlDataReader sdr = cmd.ExecuteReader();

            while (sdr.Read())
            {
                Users u = new Users();
                u.id = Convert.ToInt32(sdr["ID"]);
                u.fname = sdr["Fname"].ToString();
                u.lname = sdr["Lname"].ToString();
                u.email = sdr["Email"].ToString();

                userList.Add(u);
            }
            return JsonConvert.SerializeObject(userList);
        }


        [WebMethod]
        public string UpdateUser(string id, string Fname, string Lname, string Email)
        {
            SqlConnection con = new SqlConnection("Data Source=DESKTOP-J3PUE9B;Database=DcodeTech;Integrated Security=SSPI");
            string sql = "update user_table set Fname='" + Fname + "', Lname='" + Lname + "', Email='" + Email + "' where ID='" + id + "'";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            int status = cmd.ExecuteNonQuery();
            con.Close();
            if (status > 0)
            {
                return "Successful !";
            }
            else
            {
                return "Failure !";
            }
        }

        [WebMethod]
        public string DeleteUser(string id)
        {
            SqlConnection con = new SqlConnection("Data Source=DESKTOP-J3PUE9B;Database=DcodeTech;Integrated Security=SSPI");
            string sql = "delete from user_table where ID='" + id + "'";
            con.Open();
            SqlCommand cmd = new SqlCommand(sql, con);
            int status = cmd.ExecuteNonQuery();
            con.Close();
            if (status > 0)
            {
                return "Successful !";
            }
            else
            {
                return "Failure !";
            }
        }

    }
}
