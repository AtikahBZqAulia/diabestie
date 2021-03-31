//
//  ViewController.swift
//  Diabestie
//
//  Created by Dhiky Aldwiansyah on 24/03/21.
//

import UIKit
import AAInfographics


class DiaryViewController: UIViewController {
    
   private var aaChartView: AAChartView!
    
    @IBOutlet weak var viewChart: UIView!
    private var aaChartModel: AAChartModel!
    public var chartType: AAChartType!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpAAChartView()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "addFood"){
            let tableVC = segue.destination as! TableViewController
            tableVC.delegate = self
            tableVC.titleName = "Add Food"
        }
    }
    
    
    
    func setUpAAChartView(){
        
        aaChartView = AAChartView()
        chartType = .column
        
        let chartViewWidth = view.frame.size.width
        let chartViewHeight = view.frame.size.height - 220
        aaChartView!.frame = viewChart.frame
        view.addSubview(aaChartView!)
        aaChartView!.scrollEnabled = false//Disable chart content scrolling
        aaChartView!.isClearBackgroundColor = true
        aaChartView!.delegate = self as AAChartViewDelegate
        
//        let aaOptions = AAOptions.init()
//        aaOptions.tooltip?
//                        .shadow(false)
//                        .positioner("""
//                        function (labelWidth, labelHeight, point) {
//                            return {
//                             x : point.plotX,
//                             y : 0
//                            };
//                        }
//                        """)
//
        
        aaChartModel = AAChartModel()
            .chartType(chartType!)
            .colorsTheme(["#1e90ff","#ef476f","#ffd066","#04d69f","#25547c",])//Colors theme
            .axesTextColor(AAColor.white)
            .dataLabelsEnabled(false)
            .tooltipValueSuffix("℃")
            .animationType(.bounce)
            .touchEventEnabled(true)
            .series([
                AASeriesElement()
                    .name("Tokyo")
                    .data([0,7.0, 6.9, 9.5])
                ])
    
        configureColumnChartAndBarChartStyle()
        
//        aaChartView!.aa_drawChartWithChartOptions(aaOptions)
        let aaOptions = AAOptionsConstructor.configureChartOptions(aaChartModel)
        aaOptions.yAxis?.opposite(true)

        aaChartView!.aa_drawChartWithChartModel(aaChartModel!)
        aaChartView!.aa_drawChartWithChartOptions(aaOptions)
        viewChart.addSubview(aaChartView)
    }
    
    private func configureColumnChartAndBarChartStyle() {
        aaChartModel!
            .categories(["0", "12", "18", "23"])
            .legendEnabled(false)
            .colorsTheme(["#fe117c","#ffc069","#06caf4","#7dffc0"])
            .animationType(.easeOutCubic)
            .animationDuration(1200)
        
    }
}

extension DiaryViewController : TableViewControllerDelegate {
    
    func doSomethingWith(data: String) {
        print("DO SOMETING WITH IT \(data)")
    }
    
}


extension DiaryViewController: AAChartViewDelegate {
    open func aaChartViewDidFinishLoad(_ aaChartView: AAChartView) {
       print("🙂🙂🙂, AAChartView Did Finished Load!!!")
    }

    open func aaChartView(_ aaChartView: AAChartView, moveOverEventMessage: AAMoveOverEventMessageModel) {
        print(
            """

            selected point series element name: \(moveOverEventMessage.name ?? "")
            🔥🔥🔥WARNING!!!!!!!!!!!!!!!!!!!! Touch Event Message !!!!!!!!!!!!!!!!!!!! WARNING🔥🔥🔥
            ==========================================================================================
            ------------------------------------------------------------------------------------------
            user finger moved over!!!,get the move over event message: {
            category = \(String(describing: moveOverEventMessage.category))
            index = \(String(describing: moveOverEventMessage.index))
            name = \(String(describing: moveOverEventMessage.name))
            offset = \(String(describing: moveOverEventMessage.offset))
            x = \(String(describing: moveOverEventMessage.x))
            y = \(String(describing: moveOverEventMessage.y))
            }
            +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
            
            
            """
        )
    }
}
