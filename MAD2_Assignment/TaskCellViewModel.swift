//
//  TaskCellViewModel.swift
//  MAD2_Assignment
//
//  Created by MAD2_P01 on 18/1/21.
//

import Foundation
import Combine

class TaskCellViewModel: ObservableObject, Identifiable {
    @Published var taskRepository = TaskRepository()
    @Published var task: Task
    
    var id = ""
    @Published var completionStateIconName = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    static func newTask() -> TaskCellViewModel {
        TaskCellViewModel(task:  Task(title: "", completed: false))
    }
    
    init(task: Task){
        self.task = task
        
        $task
            .map {$0.completed ? "checkmark.circle.fill": "circle"}
            .assign(to: \.completionStateIconName, on: self)
            .store(in: &cancellables)
        
        $task
            .compactMap { $0.id }
            .assign(to: \.id, on: self)
            .store(in: &cancellables)
        
        $task
            //only send following updates after the first one
            .dropFirst()
            //task syncs to firebase in 8secs to only send updates when user stops typing
            .debounce(for: 0.8, scheduler: RunLoop.main)
            .sink { [weak self] task in
              self?.taskRepository.updateTask(task)
            }
            .store(in: &cancellables)
    }
}
