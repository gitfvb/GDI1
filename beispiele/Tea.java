public class Tea {
  // name of the tea
  private String name;
  
  // nr of spoons of tea to use
  private int nrSpoons;
  
  // time for steeping in seconds
  private int nrSecondsToSteep;
  
  public Tea(String teaName, int nrSpoonfuls, int secondsToSteep) {
    name = teaName;
    nrSpoons = nrSpoonfuls;
    nrSecondsToSteep = secondsToSteep;
  }
  
  /**
   * provides a readable rendition of this tea
   *
   * @return a String representation of this tea
   */
  public String toString() {
    StringBuilder sb = new StringBuilder(80);
    sb.append("To prepare tea '").append(name).append("', please use ");
    sb.append(nrSpoons).append(" spoons of tea leaves and let steep for ");
    sb.append(nrSecondsToSteep).append(" seconds");
    return sb.toString();
  }
  
  // get methods
  /**
   * returns the tea's name
   *
   * @return the name of the tea
   */
  public String getName() {
    return name;
  }
  
  /**
   * returns the number of spoons of tea leaves to use
   *
   * @return the number of spoons to prepare the tea
   */
  public int getNrSpoons() {
    return nrSpoons;
  }
  
  /**
   * returns the number of seconds to steep the tea
   *
   * @return the number of seconds for steeping the tea
   */
  public int getNrSecondsToSteep() {
    return nrSecondsToSteep;
  }
}