class CommonQuestionsController < ApplicationController
  def index
    @faq_array =  [CommonQuestion.new("What is TaskFull?", "TaskFull is an awesome tool that is going to change your life.  TaskFull is your one stop shop to organize all your tasks.  You'll also be able to track comments that you and others make.  TaskFull may eventually replace all need for paper and pens in the entire world.  Well, maybe not, but it's going to be pretty cool.
", "What-is-TaskFull"),
              CommonQuestion.new("How do I join TaskFull?", "As soon as it's ready for the public, you'll see a signup link in the upper right.  Once that's there, just click it and fill in the form!", "How-do-I-join-TaskFull?"),
              CommonQuestion.new("When will TaskFull be finished?", "TaskFull is a work in progress.  That being said, it should be fully functional in the next few weeks.  Functional.  Check in daily for new features and awesome functionality.  It's going to blow your mind.  Organization is just a click away.  Amazing!", "When-will-TaskFull-be-finished")]
  end
end
