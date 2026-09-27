package e_learning;

public class QuestionSearch {

    public static int linearSearch(
            String[][] questions,
            String searchText) {

        for (int i = 0; i < questions.length; i++) {

            if (questions[i][1]
                    .toLowerCase()
                    .contains(searchText.toLowerCase())) {

                return i;
            }
        }

        return -1;
    }
}