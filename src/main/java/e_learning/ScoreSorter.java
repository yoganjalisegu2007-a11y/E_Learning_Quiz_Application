package e_learning;

import java.util.ArrayList;

public class ScoreSorter {

    public static void bubbleSort(
            ArrayList<String[]> leaderboard) {

        int n = leaderboard.size();

        for (int i = 0; i < n - 1; i++) {

            for (int j = 0; j < n - i - 1; j++) {

                double percentage1 =
                    Double.parseDouble(
                        leaderboard.get(j)[3]
                    );

                double percentage2 =
                    Double.parseDouble(
                        leaderboard.get(j + 1)[3]
                    );

                if (percentage1 < percentage2) {

                    String[] temp =
                        leaderboard.get(j);

                    leaderboard.set(
                        j,
                        leaderboard.get(j + 1)
                    );

                    leaderboard.set(
                        j + 1,
                        temp
                    );
                }
            }
        }
    }
}