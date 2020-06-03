//
//  ListViewController.swift
//  NewsReader
//
//  Created by 竹村博徳 on 2020/05/31.
//  Copyright © 2020 竹村博徳. All rights reserved.
//

import UIKit

class ListViewController: UITableViewController, XMLParserDelegate {

    var parser:XMLParser!
    var items = [Item]()
    var item:Item?
    var currentString = ""

    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func  tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",
                                                 for: indexPath)
        
        cell.textLabel?.text = items[indexPath.row].title
        return cell
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        startDownload()
    }
    
    //データのDL
    func startDownload(){
        self.items = []
        if let url = URL(
            string: "https://wired.jp/rssfeeder"){
            if let parser = XMLParser(contentsOf: url){
                self.parser = parser
                self.parser.delegate = self
                self.parser.parse()
                
            }
    
            
        }
        
    }
    //記事の要素名からitemを見つける（＝必要なデータのみを抽出する）
    func parser(_ parser: XMLParser,didStartElement elementName: String,
                namespaceURI: String?,
                qualifiedName qName: String?,
                attributes attributeDict: [String : String]){
        //一時的な保存先のcurrentStringを空にする
        self.currentString = ""
        //要素名がitemの時のみitemを作成している　itemはItem.swiftを参照
        if elementName == "item"{
        self.item = Item()
        
        }
        }
    //内容を取り出す。要素名ではなく、タグの中を参照する
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        self.currentString += string
    }
    //終了タグが見つかると自動的に呼び出される　itemsに1つの記事（item）を追加する
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        switch elementName{
            case "title": self.item?.title = currentString
            case "link": self.item?.link = currentString
            case "item": self.items.append(self.item!)
            default : break
            
        }
    }
    //解析したデータの表示 return items.count とreturn cellのoverride funcが再実行される
    func parserDidEndDocument(_ parser: XMLParser) {
        self.tableView.reloadData()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = self.tableView.indexPathForSelectedRow{
            
            let item = items[indexPath.row]
            let controller = segue.destination as! DetailViewController
            controller.title = item.title
            controller.link = item.link
            
            
        }
    }
    
    
    
    
    
    
    
}
