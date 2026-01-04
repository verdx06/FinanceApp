//
//  CoordinatorFactoryProtocol.swift
//  FinanceApp
//
//  Created by Виталий Багаутдинов on 13.12.2025.
//

@MainActor
protocol CoordinatorFactoryProtocol: AnyObject
{
	func makeProfileCoordinator(logoutHandler: @escaping () -> Void) -> ProfileCoordinator
}

@MainActor
final class CoordinatorFactory: CoordinatorFactoryProtocol
{
	private let moduleFactory: ModuleFactory
	private let useCaseFactory: UseCaseFactory

	init(moduleFactory: ModuleFactory, useCaseFactory: UseCaseFactory) {
		self.moduleFactory = moduleFactory
		self.useCaseFactory = useCaseFactory
	}

	func makeProfileCoordinator(logoutHandler: @escaping () -> Void) -> ProfileCoordinator {
		ProfileCoordinator(
			moduleFactory: self.moduleFactory,
			fetchProfileInformationUseCase: self.useCaseFactory.makeFetchProfileInformationUseCase(),
			logoutHandler: logoutHandler
		)
	}
	// TODO: (SHIFTLAB-9320) Расширение фабрики координаторов
}
