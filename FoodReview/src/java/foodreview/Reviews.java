package foodreview;

public class Reviews extends Meals {
	
	String reviewName;
	
	int reviewScore;
	
	public Reviews()	{
		
	}
	
	//getters
	public String getReviewName() {
		return reviewName;
	}
	
	public int getReviewScore() {
		return reviewScore;
	}
        
        //setters
        public void setReviewName(String reviewName) {
            this.reviewName = reviewName;
        }
        
        public void setReviewScore(int reviewScore) {
            this.reviewScore = reviewScore;
        }
}