//
//  TaskListViewModel.swift
//  MAD2_Assignment
//
//  Created by Jamie on 18/1/21.
//

import Foundation
import Combine

class TaskListViewModel: ObservableObject {
    @Published var taskRepository = TaskRepository()
    @Published var taskCellViewModels = [TaskCellViewModel]()
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        taskRepository.$tasks.map { tasks in
            tasks.map{ task in
                TaskCellViewModel(task: task)
            }
        }
        .assign(to: \.taskCellViewModels, on: self)
        .store(in: &cancellables)
//        self.taskCellViewModels = testDataTasks.map { task in
//            TaskCellViewModel(task: task)
//        }
    }
    
    //adds task to UI view model & list
    func addTask(task: Task) {
        let taskVM = TaskCellViewModel(task: task)
        self.taskCellViewModels.append(taskVM)
        taskVM.id = taskRepository.addTask(task)
        
    }
    
    //removes task from UI view model & list
    func removeTasks(atOffsets indexSet: IndexSet){
        let viewModels = indexSet.lazy.map { self.taskCellViewModels[$0] }
        viewModels.forEach { taskCellViewModel in
            taskRepository.removeTask(taskCellViewModel.task)
        }
        taskCellViewModels.remove(atOffsets: indexSet)
    }
    
    //updates task when enter is pressed
    func updateTasks(task : Task){
        taskRepository.updateTask(task)
    }
}
