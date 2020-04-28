//
//  RSSTableViewController.swift
//  RSSReader
//
//  Created by chikushi on 2020/04/07.
//  Copyright © 2020 co.jp.vivinet. All rights reserved.
//

import UIKit
import Foundation


/// RSSリスト表示
class RSSTableViewController: UITableViewController {
    
    /// 取得情報
    private var newsType: NewsType = .main
    /// 記事一覧
    private var items: [Item] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // サイズ調整(効いていない)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 40
        
        // リフレッシュコントローラー
        refreshControl = UIRefreshControl()
        // リフレッシュしたときに実行する関数を追加
        refreshControl?.addTarget(self, action: #selector(RSSTableViewController.refresh(_:)), for: .valueChanged)
        
    }
    
    
    // 何を更新するのかを定義
    func refresh(){
        
    }
    
    @objc func refresh(_ sender: UIRefreshControl) {
        // レスポンスが割と速かったので、2秒後にAPIからデータを取得する
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // APIに接続してテーブルビューを更新
            self.updatePostList(sender)
        }
    }
    
    
    // APIからPOSTデータを取得
    func updatePostList(_ sender: UIRefreshControl?) -> Void {
        // メインスレッドで実行
        DispatchQueue.main.async {
            
            // データ取得と更新
            self.loadData()
            self.tableView.reloadData()
            
            // リフレッシュだとsenderがあるので、リフレッシュ完了
            if sender != nil {
                sender?.endRefreshing()
                print("refresh")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadData();
        
    }
    
    // MARK: - Table view data source
    
    
    /// <#Description#>
    /// - Parameter tableView: <#tableView description#>
    /// - Returns: <#description#>
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    /// <#Description#>
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - section: <#section description#>
    /// - Returns: <#description#>
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.items.count
    }
    
    
    
    /// TableViewセル設定(初期表示時)
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    /// - Returns: <#description#>
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "InfoTableViewCell", for: indexPath) as! CustomTableViewCell
        
        // Configure the cell...
        let url = URL(string: self.items[indexPath.row].thumbnail)
        do {
              let data = try Data(contentsOf: url!)
              cell.thumbnailImage.image = UIImage(data: data)

         }catch let err {
              print("Error : \(err.localizedDescription)")
         }
        cell.titleLabel.text = self.items[indexPath.row].title
        cell.detailLabel.text = self.items[indexPath.row].link
        
        return cell
    }
    
    
    /// tableviewセル選択時イベント
    /// - Parameters:
    ///   - tableView: <#tableView description#>
    ///   - indexPath: <#indexPath description#>
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // タップされたセルの行番号を出力
        print("\(indexPath.row)番目の行が選択されました。")
        performSegue(withIdentifier: "toWebViewController",sender: self.items[indexPath.row].link)
    }
    
    
    
    /// 画面遷移時のsenderパラメータ設定
    /// - Parameters:
    ///   - segue: <#segue description#>
    ///   - sender: <#sender description#>
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWebViewController" {
            let webViewController = segue.destination as! WebViewController
            guard let unwrapped = sender else { return }
            webViewController.targetUri = unwrapped as? String
        }
    }
    
    /// RSSデータ読込
    func loadData(){
        RssClient.fetchItems(urlString: self.newsType.urlStr, completion: { (response) in
            switch response {
            case .success(let items):
                DispatchQueue.main.async() { () -> Void in
                    self.items = items
                }
            case .failure(let err):
                print("記事の取得に失敗しました: reason(\(err))")
            }
        })
    }
    

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
