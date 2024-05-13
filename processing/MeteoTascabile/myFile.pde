import java.io.File;
import java.io.FileWriter;
import java.io.IOException;

public int TXT = 1;
public int CSV = 2;

String read = "";
String path = "";
String extension = "";
boolean selectingFile = false;

public int button = 0;

public void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    println("User selected " + selection.getAbsolutePath());
    path = selection.getAbsolutePath();
    println(button);
    if(button == TXT){
      writeTXT(path);
    }
    if(button == CSV){
      writeTable(path);
    }
  }
}

public void writeTXT(String filePath) {
  extension = ".txt";
  try {
    File file = new File(filePath + extension);
    if (file.exists()) {
      println("File already exists. Deleting...");
      if (file.delete()) {
        println("File deleted.");
      } else {
        println("Failed to delete file.");
        return; // Exit function if failed to delete file
      }
    }

    if (file.createNewFile()) {
      println("File created: " + file.getName());
      FileWriter writeFile = new FileWriter(filePath + extension);
      writeFile.write(read);
      writeFile.close();
    } else {
      println("Failed to create file.");
    }
  } catch (IOException e) {
    println("An error occurred.");
    e.printStackTrace();
  }
}

Table table;

public void writeTable(String filePath) {
  extension = ".csv";
  String values[] = read.split("\n");
  String sensor[] = {"Temperatura", "Pressione", "Umidità", "Temperatura B.U."};
  
  table = new Table();
  table.addColumn("Sensore");
  table.addColumn("Valore");
  
  for(int i = 0; i < 4; i++){
    TableRow newRow = table.addRow();
    newRow.setString("Sensore", sensor[i]);
    newRow.setString("Valore", values[i]);
  }
  println(table);
  
  try {
    File file = new File(filePath + extension);
    if (file.exists()) {
      println("File already exists. Deleting...");
      if (!file.delete()) {
        println("Failed to delete file.");
        return; // Exit function if failed to delete file
      }
    }

    if (file.createNewFile()) {
      println("File created: " + file.getName());
      saveTable(table, filePath + extension);
    } else {
      println("Failed to create file.");
    }
  } catch (IOException e) {
    println("An error occurred while writing CSV.");
    e.printStackTrace();
  }
}
