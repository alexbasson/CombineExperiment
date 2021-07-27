@testable import CombineExperiment
import Combine

class SpyMemberManager: MemberManager {
    let membersSubject = CurrentValueSubject<[Member], Never>([])
    private var addMemberArgs: AddMemberArgs?
    private var removeArgs: RemoveArgs?

    var membersPublisher: AnyPublisher<[Member], Never> {
        membersSubject.eraseToAnyPublisher()
    }

    func addMember(name: String) {
        addMemberArgs = AddMemberArgs(name: name)
    }

    func remove(member: Member) {
        removeArgs = RemoveArgs(member: member)
    }

    func addMemberWasCalled(with name: String) -> Bool {
        return addMemberArgs?.name == name
    }

    func removeWasCalled(with member: Member) -> Bool {
        return removeArgs?.member == member
    }

    struct AddMemberArgs {
        let name: String
    }

    struct RemoveArgs {
        let member: Member
    }
}
