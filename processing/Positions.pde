public class PositionHandler{
  
  public HashMap<String, float []> getPositions(){
    HashMap<String, float []> positions = new HashMap<String, float[]>();
    float [] swedenPosition = {0.634, 0.903};
    float [] paraguayPosition = {0.812, 0.597};
    float [] maliPosition = {0.647, 0.756};
    float [] cambodiaPosition = {0.266, 0.810};
    float [] palestinePosition = {0.427, 0.700};
    float [] ethiopiaPosition = {0.605, 0.597};
    float [] malawiPosition = {0.476, 0.563};
    float [] mexicoPosition = {0.864, 0.724};
    positions.put("Paraguay", paraguayPosition);
    positions.put("Sweden", swedenPosition);
    positions.put("Mali", maliPosition);
    positions.put("Cambodia", cambodiaPosition);
    positions.put("Palestine", palestinePosition);
    positions.put("Ethiopia", ethiopiaPosition);
    positions.put("Malawi", malawiPosition);
    positions.put("Mexico", mexicoPosition);
    
    return positions;
  }
  
  public HashMap<String, float []> getYearPositions(){
    HashMap<String, float []> yearPositions = new HashMap<String, float[]>();
    float [] position2000 = {0.890};
    float [] position2001 = {0.847};
    float [] position2002 = {0.804};
    float [] position2003 = {0.761};
    float [] position2004 = {0.718};
    float [] position2005 = {0.675};
    float [] position2006 = {0.632};
    float [] position2007 = {0.589};
    float [] position2008 = {0.546};
    float [] position2009 = {0.503};
    float [] position2010 = {0.460};
    float [] position2011 = {0.417};
    float [] position2012 = {0.374};
    float [] position2013 = {0.331};
    float [] position2014 = {0.288};
    float [] position2015 = {0.245};
    yearPositions.put("2000", position2000);
    yearPositions.put("2001", position2001);
    yearPositions.put("2002", position2002);
    yearPositions.put("2003", position2003);
    yearPositions.put("2004", position2004);
    yearPositions.put("2005", position2005);
    yearPositions.put("2006", position2006);
    yearPositions.put("2007", position2007);
    yearPositions.put("2008", position2008);
    yearPositions.put("2009", position2009);
    yearPositions.put("2010", position2010);
    yearPositions.put("2011", position2011);
    yearPositions.put("2012", position2012);
    yearPositions.put("2013", position2013);
    yearPositions.put("2014", position2014);
    yearPositions.put("2015", position2015);
    
    return yearPositions;
  }
  
  public HashMap<String, float[]> getLanguagePositions(){
    HashMap<String, float []> languagePositions = new HashMap<String, float[]>();
    float [] positionSwedish = {0.76};
    float [] positionEnglish = {0.60};
    languagePositions.put("Swedish", positionSwedish);
    languagePositions.put("English", positionEnglish);
    return languagePositions;
  }
}