//
//  RulesView.swift
//  Yes No Game
//
//  Created by Руслан Меланин on 19.01.2026.
//

import SwiftUI

struct RulesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {

                sectionCard {
                    Text("Как играть")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    Для игры в данетки подойдёт любая компания из двух и более человек. Один из игроков становится ведущим, остальные — отгадывают.
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("Начало игры")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    Ведущий выбирает карточку и зачитывает её название и описание. Подсказку и полную историю он смотрит заранее, но другим игрокам их не показывает.
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("Цель игры")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    Задача игроков — восстановить реальную ситуацию и понять, что произошло на самом деле.

                    Для этого они по очереди задают ведущему вопросы. Ведущий может отвечать только:
                    • «Да»
                    • «Нет»
                    • «Не имеет значения / Не знаю / Уточните вопрос»

                    Если становится сложно, игроки могут воспользоваться подсказкой. Изображение карточки доступно всем участникам.
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("Пример")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    Ведущий загадал ситуацию:
                    «Сотрудника уволили, и после этого его доход увеличился.»

                    Игроки начинают задавать вопросы:

                    — Он обманывал работодателя?
                    — Нет

                    — Он выиграл в лотерею?
                    — Нет

                    — Он совершил преступление?
                    — Не имеет значения

                    И так далее, пока история не станет понятной.
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("Зачем играть")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    Данетки — это отличная тренировка мышления. Они развивают логику, внимание к деталям и умение находить скрытые причины событий.

                    Такой формат мозгового штурма часто используют и в компаниях для развития сотрудников.
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

                sectionCard {
                    Text("Где можно играть")
                        .font(.headline)
                        .foregroundColor(.white)

                    Text("""
                    Для игры в данетки не нужны специальные условия или реквизит. В них удобно играть где угодно: в дороге, на прогулке, на вечеринке или дома — вдвоём или большой компанией.
                    """)
                    .font(.body)
                    .foregroundColor(.white)
                    .lineSpacing(2)
                }

            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.vertical)
            .padding(.horizontal, 16)
        }
        .background(
            Image("mainmenu")
                .resizable()
                .scaledToFill()
                .ignoresSafeArea()
        )
    }

    private func sectionCard<Content: View>(@ViewBuilder _ content: () -> Content) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            content()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.black.opacity(0.5))
                .shadow(radius: 5)
        )
    }
}

#Preview {
    RulesView()
}

