package board;

import java.sql.Connection;

public class LastPage {
	public int lastPage(int lastPage) {
		while(true) {
			if(lastPage%10 == 1) {
				break;
			} else {
				lastPage--;
			}
		}
		return lastPage;
	}
}
