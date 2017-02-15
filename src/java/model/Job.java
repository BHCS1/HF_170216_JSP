package model;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.logging.Level;
import java.util.logging.Logger;
import static model.Model.connect;
import static model.Model.connection;

public class Job extends Model {
  
  private String id;
  private String title;
  private int minSalary;
  private int maxSalary;

  public Job(String id, String title, int minSalary, int maxSalary) {
    this.id = id;
    this.title = title;
    this.minSalary = minSalary;
    this.maxSalary = maxSalary;
  }
  
  public static Job get(String id) {
    Job job = null;
    try {
      connect();

      String query = "SELECT job_title AS jobTitle, "
            + "job_id AS id,"
            + "min_salary AS minSalary,"
            + "max_salary AS maxSalary "
            + "FROM jobs "
            + "WHERE job_id='"+id+"'";

      ResultSet result = connection.createStatement().executeQuery(query);

      result.next();
      job = new Job(
            result.getString("id"),
            result.getString("jobTitle"),
            result.getInt("minSalary"),
            result.getInt("maxSalary")
          );
    } catch (SQLException ex) {
      ;
    } catch (ClassNotFoundException ex) {
      ;
    }

    disconnect();
    return job;
  }
  
  public static ArrayList<Job> getAll() throws ClassNotFoundException, SQLException {
    connect();
    ArrayList<Job> list = new ArrayList<>();

    String query = "SELECT job_title AS jobTitle, "
            + "job_id AS id,"
            + "min_salary AS minSalary,"
            + "max_salary AS maxSalary "
            + "FROM jobs "
            + "ORDER BY jobTitle";

    ResultSet result = connection.createStatement().executeQuery(query);

    while (result.next()) {
      list.add(
        new Job(
          result.getString("id"),
          result.getString("jobTitle"),
          result.getInt("minSalary"),
          result.getInt("maxSalary")
        )
      );
    }

    disconnect();
    return list;
  }

  public String getId() {
    return id;
  }

  public void setId(String id) {
    this.id = id;
  }

  public String getTitle() {
    return title;
  }

  public void setTitle(String title) {
    this.title = title;
  }

  public int getMinSalary() {
    return minSalary;
  }

  public void setMinSalary(int minSalary) {
    this.minSalary = minSalary;
  }

  public int getMaxSalary() {
    return maxSalary;
  }

  public void setMaxSalary(int maxSalary) {
    this.maxSalary = maxSalary;
  }

  @Override
  public boolean equals(Object obj) {
    if(!(obj instanceof Job))
      return false;
    return this.getId().equals( ((Job)obj).getId() );
    
  }
  
}
