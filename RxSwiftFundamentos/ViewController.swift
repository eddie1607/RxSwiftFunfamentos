//
//  ViewController.swift
//  RxSwiftFundamentos
//
//  Created by Edmilson vieira da silva on 15/02/21.
//  Copyright © 2021 Edmilson vieira da silva. All rights reserved.
//


//https://medium.com/ios-os-x-development/learn-and-master-%EF%B8%8F-the-basics-of-rxswift-in-10-minutes-818ea6e0a05b
import UIKit
import RxCocoa
import RxSwift

class ViewController: UIViewController {
  
  // assinando a primeira sequencia de observalel
  func firstsequence () -> (){
    let helloSequence = Observable.of("Hello RX")
    let subscription = helloSequence.subscribe {event in print(event)}
    
    
  }
  func secondSequence () -> (){
    let hellosequence  = Observable.from(["@","H","E","L","L","O"])
    let subscripiton = hellosequence.subscribe{event in event
      
      switch event {
        
            case .next(let value): print(value)
        
            case .error (let error): print(error)
        
            case .completed: print("completed")
      }
    }
    
  }
    
  // criando um disposebag para cancelar assinaturas
  let bag = DisposeBag()
  
  // criar uma sequencia observavel
  let obs = Observable.just("hello Rxswift")
  
  // criando uma assinatura para os proximos eventos variale do tipo behavior
  var publishSubject = PublishSubject<String>()
  
  //adicionando valores a essa sequencia usando a funcao onNext
  func subscrition1 () ->(){
   publishSubject.onNext("Hello")
    publishSubject.onNext("word")
    let subscrition1: () = publishSubject.subscribe(onNext:{print($0)}).disposed(by: bag)
  }
  
  // criando  uma nova assinatura  e adicionado novos valores
    func subscrition2() ->(){
      let subscrition1 = publishSubject.subscribe(onNext:{print(#line,$0)})
      publishSubject.onNext("Both subscription receive this message")

  }
  //stransformando dados antes  que eles cheguem aos seus assinantes com funcao - map
  func mapTest () -> (){
    Observable<Int>.of(1,2,3,4).map{value in  return value * 10 }.subscribe(onNext:{
      print($0)
    })
  }
  // mescla a  emissao de observaveis  resultntes e observaveis  da primeira sequencia
  func flapMap() -> (){
    let sequence1 = Observable <Int> .of (1,2)
    let sequence2 = Observable <Int> .of(1,2)
    let sequenceOfsequences = Observable.of(sequence1,sequence2)
    sequenceOfsequences.flatMap {return $0}.subscribe(onNext: {
      print ($0)
    })
  }
  // aparatir de um ponto inicial vai agregando valores assim  como reduzir
  func scan ()->(){
    Observable.of(1,2,3,4,5).scan(0){ seed, value in
      return seed + value
    }.subscribe(onNext:{print ($0)})
  }
// bufer
  
  func filter () ->(){
    Observable.of(2,30,22,5,60,1).filter{$0 > 10}.subscribe(onNext:{print($0)})
  }

  override func viewDidLoad() {
    //firstsequence()
    secondSequence()
    //subscrition1()
    //subscrition2()
    //mapTest()
    //flapMap()
   // filter()
   // scan()
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    
    }


}

