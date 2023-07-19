//
//  ViewController.swift
//  CustomHeader
//
//  Created by Preeteesh Remalli on 19/06/23.
//

import UIKit
struct Section {
    var title: String
    var subSections: [SubSection]
}

struct SubSection {
    var title: String
    var rows: [Row]
}

struct Row {
    var title: String
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var sections: [Section] = []
    var sectionExpandedState: [Bool] = []
    var subSectionExpandedState: [[Bool]] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self

        // Populate your sections, sub-sections, and rows data
        sections = [
            Section(title: "Section 1", subSections: [
                SubSection(title: "Sub-Section 1-1", rows: [
                    Row(title: "Row 1-1-1"),
                    Row(title: "Row 1-1-2"),
                    Row(title: "Row 1-1-3")
                ]),
                SubSection(title: "Sub-Section 1-2", rows: [
                    Row(title: "Row 1-2-1"),
                    Row(title: "Row 1-2-2")
                ])
            ]),
            Section(title: "Section 2", subSections: [
                SubSection(title: "Sub-Section 2-1", rows: [
                    Row(title: "Row 2-1-1"),
                    Row(title: "Row 2-1-2")
                ])
            ])
        ]

        // Initialize the expanded state arrays with default values
        sectionExpandedState = Array(repeating: true, count: sections.count)
        subSectionExpandedState = Array(repeating: [], count: sections.count)
        for i in 0..<sections.count {
            let subSectionCount = sections[i].subSections.count
            subSectionExpandedState[i] = Array(repeating: false, count: subSectionCount)
        }
    }

    // Rest of your code
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 44))
        headerView.backgroundColor = UIColor.lightGray

        // Add a tap gesture recognizer to the header view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
        headerView.addGestureRecognizer(tapGestureRecognizer)
        headerView.tag = section

        // Add a label for the section title
        let label = UILabel(frame: CGRect(x: 16, y: 11, width: tableView.frame.width - 32, height: 20))
        label.text = sections[section].title
        headerView.addSubview(label)

        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 44
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.01
    }

    @objc func headerTapped(_ recognizer: UITapGestureRecognizer) {
        guard let tappedView = recognizer.view else { return }
        let section = tappedView.tag

        // Toggle the expanded state of the section
        sectionExpandedState[section].toggle()

        // Reload the section to update its visibility
        tableView.reloadData()
    }

//    @objc func subSectionHeaderTapped(_ recognizer: UITapGestureRecognizer) {
//        guard let tappedView = recognizer.view else { return }
//        let section = tappedView.tag
//        let subSection = tappedView.tag % 100
//
//        // Toggle the expanded state of the sub-section
//        subSectionExpandedState[section][subSection].toggle()
//
//        // Reload the section to update the visibility of the sub-section
//        tableView.reloadData()
//
//    }
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print()
//
//        print()
        subSectionExpandedState[indexPath.section][indexPath.row].toggle()
        tableView.reloadData()

        print("dsfsdf")
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sec = sections[section]

        // Check if the section is expanded or collapsed
        if sectionExpandedState[section] {
            var totalRows = sec.subSections.count // Include the sub-sections

            // Check if the sub-sections are expanded or collapsed
            for subSection in sec.subSections {
                if subSectionExpandedState[section][0] {
                    totalRows += subSection.rows.count // Include the rows
                }
            }

            return totalRows
        } else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        let section = sections[indexPath.section]

        var totalSubSections = section.subSections.count
        var currentRow = 0

        // Find the corresponding sub-section and row for the given indexPath
        var targetSubSection: SubSection?
        var targetRow: Row?

        for subSection in section.subSections {
            if subSectionExpandedState[indexPath.section][0] {
                totalSubSections += 1 // Include the expanded sub-sections

                if currentRow == indexPath.row {
                    targetSubSection = subSection
                    break
                }

                if currentRow + 1 <= indexPath.row && indexPath.row < currentRow + subSection.rows.count + 1 {
                    targetSubSection = subSection
                    targetRow = subSection.rows[indexPath.row - currentRow - 1]
                    break
                }

                currentRow += subSection.rows.count + 1
            } else {
                if currentRow == indexPath.row {
                    targetSubSection = subSection
                    break
                }

                currentRow += 1
            }
        }

        // Configure the cell with the appropriate content
        if let subSection = targetSubSection {
            if let row = targetRow {
                // Display row title
                cell.textLabel?.text = "\(row.title)"
            } else {
                // Display sub-section title
//                let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(headerTapped(_:)))
//                cell.addGestureRecognizer(tapGestureRecognizer)
//                cell.tag = 0
                cell.textLabel?.text = "\(subSection.title)"
                
            }
        }

        return cell
    }
}

/*

    import UIKit

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return nil }
        let options: [NSAttributedString.DocumentReadingOptionKey: Any] = [
            .documentType: NSAttributedString.DocumentType.html,
            .characterEncoding: String.Encoding.utf8.rawValue
        ]
        return try? NSAttributedString(data: data, options: options, documentAttributes: nil)
    }
}

func createAttributedStringFromHTML(htmlString: String, font: UIFont) -> NSAttributedString? {
    let attributedString = NSMutableAttributedString()
    
    // Convert HTML to attributed string
    if let htmlAttributedString = htmlString.htmlToAttributedString {
        attributedString.append(htmlAttributedString)
    }
    
    // Set the font and size for the entire string
    let attributes: [NSAttributedString.Key: Any] = [
        .font: font
    ]
    attributedString.addAttributes(attributes, range: NSRange(location: 0, length: attributedString.length))
    
    return attributedString
}

// Example usage:
if let helveticaFont = UIFont(name: "Helvetica", size: 14) {
    let htmlString = "<p>This is a <b>bold</b> and <i>italic</i> text.</p>"
    let attributedString = createAttributedStringFromHTML(htmlString: htmlString, font: helveticaFont)
    
    // Now you can use the attributedString in your UILabel, UITextView, etc.
    // For example, setting it to a UILabel:
    let label = UILabel()
    label.attributedText = attributedString
}


*/








