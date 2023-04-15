import { Character } from "../model/character/character";
import { CharacterItem } from "../model/character/character-list-item";
import { InfoApi } from "../model/info-type";
import { Api } from "./config";

type CharacterApi = {
  info: InfoApi,
  results: Character[]
}
const getAll = async (): Promise<CharacterItem[]> => {
  try {
    const { data } = await Api.get<CharacterApi>('/character');
    return data.results;
  } catch (error) {
    console.error(error);
    throw new Error('Erro ao tentar buscar os registros!')
  }
};

const getByName = async (nome?: string): Promise<CharacterItem[]> => {
  try {
    const param = (nome?.length === 0) ? undefined : nome;
    const { data } = await Api.get<CharacterApi>(`/character/?name=${param}`);
    return data.results;
  } catch (error) {
    console.error(error);
    throw new Error('Erro ao tentar buscar os registros!')
  }
};

const getById = async (id: number): Promise<Character> => {
  try {
    const { data } = await Api.get<Character>(`/character/${id}`);
    console.log(data)
    return data;
  } catch (error) {
    console.error(error);
    throw new Error('Erro ao tentar buscar os registros!')
  }
}


export const CharacterService = {
  getAll,
  getByName,
  getById
}