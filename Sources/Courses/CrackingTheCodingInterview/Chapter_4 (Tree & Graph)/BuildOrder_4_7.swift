//
//  BuildOrder_4_7.swift
//  LeetCode
//
//  Created by Maxim Eremenko on 25/12/2018.
//  Copyright © 2018 Eremenko Maxim. All rights reserved.
//

import XCTest

class BuildOrder_4_7: XCTestCase {
    
    /// You are given a list of projects and a list of dependencies (which
    /// is a list of pairs of projects, where the first project is dependent
    /// on the second project).
    ///
    /// All of a project's dependencies must be built before the project is.
    /// Find a build order that will allow the projects to be built.
    /// If there is no valid build order, return an error.
    ///
    /// Input:
    /// projects: a, b, c, d, e, f
    /// dependencies: (d, a), (b, f), (d, b), (a, f), (c, d)
    ///
    /// Output: f, e, a, b, d, c
    
    func test_makeBuildOrder_withCorrectInput_isCorrect() throws {
        
        let input = makeCorrectInput()
        
        let result = try makeBuildOrder(input)
        
        XCTAssertEqual(result, input.expected)
    }
    
    func test_makeBuildOrder_withLoopedInput_shouldThrow() throws {
        
        let input = makeLoopedInput()
        
        XCTAssertThrowsError(try makeBuildOrder(input))
    }
}

extension BuildOrder_4_7 {
    
    typealias Mapping = [String: List<String>]
    
    func makeBuildOrder(_ input: Input) throws -> [String] {
        
        var mapping = makeMapping(input)
        
        var order = [String]()
        var processing = Set<String>()
        
        for project in input.projects {
            try _makeBuildOrder(project, &mapping, &order, &processing)
        }
        
        return order
    }
    
    private enum TaskError: Error {
        case dependencyCycle
    }
    
    private func _makeBuildOrder(
        _ project: String,
        _ mapping: inout Mapping,
        _ order: inout [String],
        _ processing: inout Set<String>) throws
    {
        guard let dependencies = mapping[project] else { return }
        
        guard !processing.contains(project) else { throw TaskError.dependencyCycle }
        processing.insert(project)
        
        for dependency in dependencies {
            try _makeBuildOrder(dependency, &mapping, &order, &processing)
        }
        
        order.append(project)
        mapping[project] = nil
        processing.remove(project)
    }
    
    private func makeMapping(_ input: Input) -> Mapping {
        
        var mapping = Mapping()
        
        input.projects.forEach { mapping[$0] = List<String>() }
        
        for (project, dependency) in input.dependencies {
            var list = mapping[project]
            list?.addTo(end: dependency)
            mapping[project] = list
        }
        
        return mapping
    }
}

extension BuildOrder_4_7 {
    
    typealias Projects = [String]
    typealias Dependencies = [(project: String, dependency: String)]
    typealias Input = (
        projects: Projects,
        dependencies: Dependencies,
        expected: Projects
    )
    
    private func makeCorrectInput() -> Input {
        /// To figure out the problem and test the solution, our example (graph):
        ///
        /// - should contain multiple parts
        /// - should be big enough
        /// - should contain a node that can't be immediately followed (node with
        ///   more than one parent)
        
        let projects = ["a", "b", "c", "d", "f", "e", "k"]
        let dependencies = [("f", "a"), ("f", "b"), ("a", "c"),
                            ("b", "c"), ("c", "d"), ("e", "k")]
        
        let expected = ["d", "c", "a", "b", "f", "k", "e"]
        
        return Input(projects, dependencies, expected)
    }
    
    private func makeLoopedInput() -> Input {
        
        let projects = ["a", "b", "c"]
        let dependencies = [("a", "b"), ("c", "b"), ("b", "a")]
        
        return Input(projects, dependencies, [])
    }
}
