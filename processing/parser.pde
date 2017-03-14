public class Parser {
  public HashMap<String, HashMap<Integer, String>> parse(String fileName){
    HashMap<String, HashMap<Integer, String>> map = new HashMap<String, HashMap<Integer, String>>();
    
    table = loadTable(fileName, "header");
    
    for (TableRow row : table.rows()) {
      year = 2015;
      String countryName = row.getString(0);
      HashMap<Integer, String> country = new HashMap<Integer, String>();
      for(int i = 1; i < row.getColumnCount(); i++){
          if(row.getString(i) != null){
            country.put(year, row.getString(i));
            year--;
          }
      }
    
    map.put(countryName, country);
    
    }
    
    return map;
  }
  
  /*public HashMap <String, AudioPlayer> getAudioFiles(){
    HashMap<String, AudioPlayer> map = new HashMap<>();
    String format = ".mp3";
    map.put("SwedenEnglish", null));
    map.put("SwedenSwedish", minim.loadFile("SwedenSwedish" + format, 2048));
    map.put("ParaguayEnglish", minim.loadFile("ParaguayEnglish" + format, 2048));
    map.put("ParaguaySwedish", minim.loadFile("ParaguaySwedish" + format, 2048));
    map.put("MexicoEnglish", minim.loadFile("MexicoEnglish" + format, 2048));
    map.put("MexicoSwedish", minim.loadFile("MexicoSwedish" + format, 2048));
    map.put("PalestineEnglish", minim.loadFile("PalestineEnglish" + format, 2048));
    map.put("PalestineSwedish", minim.loadFile("PalestineSwedish" + format, 2048));
    map.put("EthiopiaSwedish", minim.loadFile("EthiopiaSwedish" + format, 2048));
    map.put("EthiopiaEnglish", minim.loadFile("EthiopiaEnglish" + format, 2048));
    map.put("CamobiaSwedish", minim.loadFile("CambodiaSwedish" + format, 2048));
    map.put("CamobiaEnglish", minim.loadFile("CambodiaEnglish" + format, 2048));
    map.put("MaliEnglish", minim.loadFile("MaliEnglish" + format, 2048));
    map.put("MaliSwedish", minim.loadFile("MaliSwedish" + format, 2048));
    map.put("MalawiEnglish", minim.loadFile("MalawiEnglish" + format, 2048));
    map.put("MalawiSwedish", minim.loadFile("MalawiSwedish" + format, 2048));
    
    return map;
  }*/
}