class TasksController < ApplicationController

  def default_serializer_options
    {root: false}
  end

  respond_to :json

  def index

    @tasks = Task.all
    respond_with(@tasks)
  end

  def show
    @task = Task.find(params[:id])
    respond_with(@task)
  end

  def create
    @task = Task.new(task_params)

    if @task.save
      respond_with(@task)
    else
      respond_with(@task.errors)
    end
  end

  def update
    @task = Task.find(task_params[:id])

    if @task.update(task_params)
      respond_with(@task) do |format|
        format.json {
          if @task.valid?
            render json: @task
          else
            render json: @task.errors, status: :unprocessable_entity
          end
        }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])
    @task.destroy

    head :no_content
  end

  private

  def task_params
    params.require(:task).permit(:id, :task, :completed_at)
  end
end
