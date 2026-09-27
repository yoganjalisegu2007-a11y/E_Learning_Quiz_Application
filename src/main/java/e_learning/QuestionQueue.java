package e_learning;

import java.util.LinkedList;
import java.util.Queue;

public class QuestionQueue {

    private Queue<String[]> questions;

    public QuestionQueue() {

        questions = new LinkedList<>();

    }

    public void addQuestion(String[] question) {

        questions.add(question);

    }

    public String[] getQuestion() {

        return questions.poll();

    }

    public boolean isEmpty() {

        return questions.isEmpty();

    }

    public int size() {

        return questions.size();

    }
}