module ChartsHelper

  def chart_departments_by_question_pie(question)
    pie_chart departments_by_question_pie_charts_path(question: question),
      {
        library: {
          title: {text: "Pytanie #{question}"},
          subtitle: {text: t("surveys.question_#{question}.body") + "<br>I - 3 pkt, II - 2 pkt, III - 1pkt"},
          tooltip: {
            pointFormat: 'Ilość: <b>{point.y} ({point.percentage:.1f}%)</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
              }
            }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_departments_sum_pie
    pie_chart departments_sum_pie_charts_path,
      {
        library: {
          title: {text: 'Suma punktów wszystkich pytań'},
          subtitle: {text: 'I - 3 pkt, II - 2 pkt, III - 1pkt'},
          tooltip: {
            pointFormat: 'Ilość: <b>{point.y} ({point.percentage:.1f}%)</b>'
          },
          plotOptions: {
            pie: {
              allowPointSelect: true,
              cursor: 'pointer',
              dataLabels: {
                enabled: true,
                format: '<b>{point.name}</b>: {point.y} ({point.percentage:.1f} %)',
              }
            }
          },
          credits: {
            enabled: false
          }
        }
      }
  end

  def chart_departments_by_question_column(question)
    column_chart departments_by_question_column_charts_path(question: question),
      {
        discrete: true,
        library: {
          title: {text: "Pytanie #{question}"},
          subtitle: {text: t("surveys.question_#{question}.body") + "<br>I - 3 pkt, II - 2 pkt, III - 1pkt"},
          credits: {
            enabled: false
          },
          legend: {
              align: 'right',
              verticalAlign: 'top',
              layout: 'vertical',
              x: 0,
              y: 20
          }

        }
      }
  end

  def chart_departments_sum_column
    column_chart departments_sum_column_charts_path,
      {
        discrete: true,
        library: {
          title: {text: 'Suma punktów wszystkich pytań'},
          subtitle: {text: 'I - 3 pkt, II - 2 pkt, III - 1pkt'},
          credits: {
            enabled: false
          },
          legend: {
              align: 'right',
              verticalAlign: 'top',
              layout: 'vertical',
              x: 0,
              y: 20
          }

        }
      }
  end

end