;MISSION 1 - DRILL FOR MINERALS, STUDY IT AND BRING BACK THE REPORT
;IF VORTEX IS PRESENT, BRING THE VORTEX SCAN REPORT ALSO
; 
(define (problem cwproblem1)
  (:domain cw1)

  (:objects
        ca - captain
        na - navigator
        sub - submarine
        br - bridge
        uw1 uw2 uw3 - underWaterRegion        ;uw3 is a helper variable
        ridge abyssal - region
        vo - vortex
        sciOff minSciOff vorSciOff - scienceOfficer
        scLab - sciLab
        vorEng opLaunchEng opMsEng - engineer
        mac - machine
        vrep - vortexReport
      drillMS - drillMiniSub
      min - mineral
      lBay - launchBay
          
      siBay - sickBay
        
      mrep - mineralReport
      

      expMS - expMiniSub
        
      sn - sensorNet
        
      base - baseUW
      leader - baseLeader
      se - security
      atl - atlanteans

      rob - robot

      brep - baseReport
      srep - sensorReport
      port - seaPort
      portSys - portSystem

      fo - fossil
      fd - fossilDetector
      st - storage
      fr - fossilReport
  )

  (:init
      (onBridge ca br)              ;Captain and Navigator are prsent on the bridge
      (onBridge na br)

     
     (order ca na ridge)            ;captain orders the navigator to travel to ridge
      
      (contains uw1 ridge)          ;the underwater region contains the ridge

      (onLaunchBay opLaunchEng lBay)          ;opLauncheng is an engineer who is present on the launch bay and helps in launching the drill minisub
      (onLaunchBayMS drillMS lBay)            ;drill minisub is present on the launch bay
      (operateLaunch opLaunchEng)

      ;a personnel can travel from launch bay to sick bay and vice versa
      (adjacent lBay siBay)
      (adjacent siBay lBay)
      
      ;a personnel can travel from bridge to launch bay and vice versa
      (adjacent br lBay)
      (adjacent lBay br)
      
      ;a personnel can travel from science lab to sick bay and vice versa
      (adjacent scLab siBay)
      (adjacent siBay scLab)

      (presentInRidge min ridge) ;minerals are prsent on the ridge

      (at sciOff lBay)    ;;science officer collects the minerals from launch bay

      (presentInSubSection minSciOff scLab)       ;mineral science officer is present in the science lab
      (presentInSubSection vorSciOff scLab)       ;vortex science officer is present in the science lab

      (containsVortex ridge vo)                   ;ridge contains the vortex
     
      (orderV ca na vo)                           ;captain orders the navigator to enter the vortex
    
      (activatedPressureShields vorEng)           ;pressure shields are up by the engineer
        
  )

  (:goal
      (and
          (drill min)
          (generateReport mac mrep) 
          
          

         (location sub uw2)
         (generateReport mac vrep)

       (atPortSystem mrep portSys)
       (atPortSystem vrep portSys)
      )
  )
)
