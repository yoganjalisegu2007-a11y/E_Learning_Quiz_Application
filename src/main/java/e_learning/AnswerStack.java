package e_learning;

import java.util.Stack;

public class AnswerStack {

    private Stack<String> answers;

    public AnswerStack() {
        answers = new Stack<>();
    }

    public void pushAnswer(String answer) {
        answers.push(answer);
    }

    public String popAnswer() {
        if (!answers.isEmpty()) {
            return answers.pop();
        }

        return null;
    }

    public boolean isEmpty() {
        return answers.isEmpty();
    }

    public int size() {
        return answers.size();
    }
}