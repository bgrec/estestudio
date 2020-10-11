import Foundation
import CoreData

// MARK: - TimeIntervalsCoreData

struct TimeIntervalsCoreData {

    let managedObjectContext: NSManagedObjectContext
    let appointment: Appointment

    init(context: NSManagedObjectContext, appointment: Appointment) {
        self.managedObjectContext = context
        self.appointment = appointment
        //self.deleteAll()
        //self.addIfEmpty()

    }

    func addToCoreData(timeInterval: TimeInterval, order: Int) {

        let newCoreDataTimeInterval = NotificationsTimeIntervals(context: self.managedObjectContext)

        newCoreDataTimeInterval.id = UUID()
        newCoreDataTimeInterval.appointmentId = Int32(self.appointment.id)
        newCoreDataTimeInterval.timeInterval = timeInterval.timeInterval
        newCoreDataTimeInterval.text = timeInterval.text
        newCoreDataTimeInterval.order = Int16(order)

        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    func updateTimeIntervalsCoreData(order: Int, timeInterval: TimeInterval) {

        let fetchRequest =  NSFetchRequest<NotificationsTimeIntervals>(entityName: "NotificationsTimeIntervals")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let predicate = NSPredicate(format: "appointmentId == %i AND order == %u", Int32(self.appointment.id), Int16(order))
        fetchRequest.predicate = predicate
        //fetchRequest.returnsObjectsAsFaults = false
        //fetchRequest.fetchLimit = 1
        do {
            let timeIntervals = try self.managedObjectContext.fetch(fetchRequest) as [NotificationsTimeIntervals]
            //print(timeIntervals.count)
            let timeIntervalUpdated = timeIntervals[0] as NotificationsTimeIntervals
            timeIntervalUpdated.text = timeInterval.text
            timeIntervalUpdated.timeInterval = timeInterval.timeInterval

            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
        } catch {
            print(error.localizedDescription)
        }

        if order == 1 && timeInterval.timeInterval == 0 {
            self.updateTimeIntervalsCoreData(order: 2, timeInterval: TimeInterval.defaultEmpty)
        }

    }

    func timeIntervalsFiltered(order: Int) -> [NotificationsTimeIntervals] {

        var timeIntervals = [NotificationsTimeIntervals]()

        let fetchRequest =  NSFetchRequest<NotificationsTimeIntervals>(entityName: "NotificationsTimeIntervals")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let predicate = NSPredicate(format: "appointmentId == %i AND order == %u", Int32(self.appointment.id), Int16(order))
        fetchRequest.predicate = predicate
        //fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.fetchLimit = 1

        do {
            let result = try self.managedObjectContext.fetch(fetchRequest)
            for timeInterval in result as [NotificationsTimeIntervals] {
                timeIntervals.append(timeInterval)
            }
            return timeIntervals
        } catch let error {
            print(error)
            return  timeIntervals  }
    }

    func addIfEmpty() {

        let timeIntervalsFiltered = self.timeIntervalsFiltered(order: 1)

        if timeIntervalsFiltered.compactMap({$0}).isEmpty {
            self.addToCoreData(timeInterval: TimeInterval.defaultFirst, order: 1)
            self.addToCoreData(timeInterval: TimeInterval.defaultEmpty, order: 2)
        }
    }

    func firstTimeInterval() -> TimeInterval {
        var timeIntervalsFiltered = self.timeIntervalsFiltered(order: 1)
        if timeIntervalsFiltered.isEmpty {
            self.addToCoreData(timeInterval: TimeInterval.defaultFirst, order: 1)
            timeIntervalsFiltered = self.timeIntervalsFiltered(order: 1).compactMap({$0})
        }

        guard let text = timeIntervalsFiltered.first?.text else { return TimeInterval.defaultFirst }
        guard let timeInterval = timeIntervalsFiltered.first?.timeInterval else { return TimeInterval.defaultFirst }

        return TimeInterval(text: text, timeInterval: timeInterval)
    }

    func secondTimeInterval() -> TimeInterval {
        var timeIntervalsFiltered = self.timeIntervalsFiltered(order: 2).compactMap({$0})
        if timeIntervalsFiltered.isEmpty {
            self.addToCoreData(timeInterval: TimeInterval.defaultEmpty, order: 2)
            timeIntervalsFiltered = self.timeIntervalsFiltered(order: 2).compactMap({$0})
        }
        guard let text = timeIntervalsFiltered.last?.text else { return TimeInterval.defaultEmpty }
        guard let timeInterval = timeIntervalsFiltered.last?.timeInterval else { return TimeInterval.defaultEmpty }

        return TimeInterval(text: text, timeInterval: timeInterval)
    }

    private func deleteAll() {

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "NotificationsTimeIntervals")
        do {
            let timeIntervals = try managedObjectContext.fetch(fetchRequest)
            for timeInterval in timeIntervals {
                // swiftlint:disable force_cast
                managedObjectContext.delete(timeInterval as! NSManagedObject)
                // swiftlint:enable force_cast
            }
        } catch let error as NSError {
            print(error)
        }

        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }

    }

    func deleteForAppointment(appointment: Appointment) {

        let fetchRequest =  NSFetchRequest<NotificationsTimeIntervals>(entityName: "NotificationsTimeIntervals")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let predicate = NSPredicate(format: "appointmentId == %i", Int32(appointment.id))
        fetchRequest.predicate = predicate

        do {
            let timeIntervals = try managedObjectContext.fetch(fetchRequest)
            for timeInterval in timeIntervals {
                managedObjectContext.delete(timeInterval as NSManagedObject)
            }
        } catch let error as NSError {
            print(error)
        }

        do {
            try self.managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
    }

    static func deleteTimeIntervalsOfMissingAppointments(managedObjectContext: NSManagedObjectContext, appointments: [Appointment]) {

        let fetchRequest =  NSFetchRequest<NotificationsTimeIntervals>(entityName: "NotificationsTimeIntervals")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        do {
            let timeIntervals = try managedObjectContext.fetch(fetchRequest)
            for timeInterval in timeIntervals {
                if !appointments.map({ Int32($0.id) }).contains(timeInterval.appointmentId) {
                    managedObjectContext.delete(timeInterval as NSManagedObject)
                }
            }
        } catch let error as NSError {
            print(error)
        }

        do {
            try managedObjectContext.save()
        } catch {
            print(error.localizedDescription)
        }
        
    }

    /*mutating func updateFirstTimeInterval(timeInterval: TimeInterval) {

        let fetchRequest =  NSFetchRequest<NotificationsTimeIntervals>(entityName: "NotificationsTimeIntervals")
        let sortDescriptor = NSSortDescriptor(key: "id", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]

        let predicate = NSPredicate(format: "appointmentId == %i AND order == %u", Int32(self.appointment.id), Int16(1))
        fetchRequest.predicate = predicate
        fetchRequest.returnsObjectsAsFaults = false
        fetchRequest.fetchLimit = 1
        do {
            let timeIntervals = try managedObjectContext.fetch(fetchRequest) as [NotificationsTimeIntervals]
            print(timeIntervals.count)
            //let timeIntervalUpdated = timeIntervals[0] as NotificationsTimeIntervals
            //timeIntervalUpdated.text = timeInterval.text
            //timeIntervalUpdated.timeInterval = timeInterval.timeInterval
            do {
                try self.managedObjectContext.save()
            } catch {
                print(error)
            }
            print("saved")
        } catch {
            print("notsaved")
            print(error.localizedDescription)
        }
    }*/

    func timeIntervalModifiers() -> [Double] {
        var timeIntervals = [Double]()
        let first = self.firstTimeInterval().timeInterval
        let second = self.secondTimeInterval().timeInterval

        timeIntervals.append(first)
        if second != 0 {
            timeIntervals.append(second)
        }

        return timeIntervals
    }

}
