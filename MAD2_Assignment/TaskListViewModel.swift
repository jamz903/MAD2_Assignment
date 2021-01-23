//
//  TaskListViewModel.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 18/1/21.
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
    
    func addTask(task: Task) {
        taskRepository.addTask(task)
        let taskVM = TaskCellViewModel(task: task)
        self.taskCellViewModels.append(taskVM)
        
    }
    
    func removeTasks(atOffsets indexSet: IndexSet){
        let viewModels = indexSet.lazy.map { self.taskCellViewModels[$0] }
        viewModels.forEach { taskCellViewModel in
            taskRepository.removeTask(taskCellViewModel.task)
        }
        taskCellViewModels.remove(atOffsets: indexSet)
    }
}
